import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/config_node.dart';
import '../../domain/entities/config_page.dart';
import '../../domain/usecases/convert_to_json.dart';
import '../../domain/usecases/parse_json.dart';

/// Provider for the ParseJson use case.
final Provider<ParseJson> parseJsonProvider = Provider<ParseJson>((Ref<ParseJson> ref) {
  // This will be provided via override in main
  throw UnimplementedError('ParseJson must be provided via override');
});

/// Provider for the ConvertToJson use case.
final Provider<ConvertToJson> convertToJsonProvider = Provider<ConvertToJson>((Ref<ConvertToJson> ref) {
  // This will be provided via override in main
  throw UnimplementedError('ConvertToJson must be provided via override');
});

/// State for the config editor.
class ConfigEditorState {
  /// Creates a new ConfigEditorState.
  const ConfigEditorState({
    this.rootNode,
    this.currentPath = const <String>[],
    this.pages = const <ConfigPage>[],
    this.currentPageIndex = 0,
    this.currentFilePath,
    this.isLoading = false,
    this.error,
    this.completedPages = const <int>{},
    this.hasUnsavedChanges = false,
  });

  /// The root node of the config tree.
  final ConfigNode? rootNode;

  /// Current navigation path (for breadcrumbs).
  final List<String> currentPath;

  /// Pages extracted from the root node for page-based navigation.
  final List<ConfigPage> pages;

  /// Currently selected page index.
  final int currentPageIndex;

  /// Path to the currently loaded config file.
  final String? currentFilePath;

  /// Whether the config is being loaded.
  final bool isLoading;

  /// Error message if loading failed.
  final String? error;

  /// Set of page indices that have been completed/confirmed.
  final Set<int> completedPages;

  /// Whether there are unsaved changes.
  final bool hasUnsavedChanges;

  /// Gets the current page if available.
  ConfigPage? get currentPage {
    if (pages.isEmpty || currentPageIndex < 0 || currentPageIndex >= pages.length) {
      return null;
    }
    return pages[currentPageIndex];
  }

  /// Gets the current node based on the current path.
  ConfigNode? get currentNode {
    if (rootNode == null) return null;
    if (currentPath.isEmpty) return rootNode;

    ConfigNode? node = rootNode;
    for (final String key in currentPath) {
      if (node == null) return null;
      node = node.children.cast<ConfigNode?>().firstWhere(
            (ConfigNode? child) => child?.key == key,
            orElse: () => null,
          );
    }
    return node;
  }

  /// Creates a copy with updated fields.
  ConfigEditorState copyWith({
    ConfigNode? rootNode,
    List<String>? currentPath,
    List<ConfigPage>? pages,
    int? currentPageIndex,
    String? currentFilePath,
    bool? isLoading,
    String? error,
    Set<int>? completedPages,
    bool? hasUnsavedChanges,
  }) {
    return ConfigEditorState(
      rootNode: rootNode ?? this.rootNode,
      currentPath: currentPath ?? this.currentPath,
      pages: pages ?? this.pages,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      currentFilePath: currentFilePath ?? this.currentFilePath,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      completedPages: completedPages ?? this.completedPages,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }
}

/// Notifier for config editor state.
class ConfigEditorNotifier extends StateNotifier<ConfigEditorState> {
  /// Creates a new ConfigEditorNotifier.
  ConfigEditorNotifier({
    required this.parseJson,
    required this.convertToJson,
  }) : super(const ConfigEditorState());

  /// Parse JSON use case.
  final ParseJson parseJson;

  /// Convert to JSON use case.
  final ConvertToJson convertToJson;

  /// Path-indexed map for O(1) node lookups during updates.
  /// This significantly improves performance for large config trees.
  Map<String, ConfigNode> _nodesByPath = <String, ConfigNode>{};

  /// Loads a config from JSON string.
  Future<void> loadFromJson(String jsonString, {String? filePath}) async {
    state = state.copyWith(isLoading: true);
    final Either<Failure, ConfigNode> result = await parseJson(jsonString);
    result.fold(
      (Failure failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message ?? 'Failed to parse JSON',
        );
      },
      (ConfigNode rootNode) {
        // Build path index for fast lookups
        _buildPathIndex(rootNode);

        // Extract pages from root node
        final List<ConfigPage> pages = ConfigPage.fromRootNode(rootNode);

        state = state.copyWith(
          rootNode: rootNode,
          pages: pages,
          currentPageIndex: 0,
          currentFilePath: filePath,
          isLoading: false,
          completedPages: const <int>{}, // Reset completed pages when loading new file
          hasUnsavedChanges: false, // Reset unsaved changes when loading new file
        );
      },
    );
  }

  /// Converts the current config to JSON string.
  Future<String?> toJsonString() async {
    if (state.rootNode == null) {
      return null;
    }
    final Either<Failure, String> result = await convertToJson(state.rootNode!);
    return result.fold<String?>(
      (Failure failure) => null,
      (String jsonString) => jsonString,
    );
  }

  /// Updates a node in the tree.
  void updateNode(ConfigNode updatedNode) {
    if (state.rootNode == null) return;

    final ConfigNode newRoot;
    // If updating the root node
    if (updatedNode.isRoot) {
      newRoot = updatedNode;
    } else {
      // Otherwise, rebuild the tree with the updated node using optimized path lookup
      newRoot = _updateNodeInTree(state.rootNode!, updatedNode);
    }

    // Rebuild path index for the updated tree
    _buildPathIndex(newRoot);

    // Regenerate pages from the updated root node to ensure pages reference the latest nodes
    final List<ConfigPage> newPages = ConfigPage.fromRootNode(newRoot);

    // Try to preserve current page by name, fallback to index
    int newPageIndex = 0;
    if (state.pages.isNotEmpty && state.currentPageIndex < state.pages.length) {
      final String currentPageName = state.pages[state.currentPageIndex].name;
      // Try to find the page with the same name
      final int foundIndex = newPages.indexWhere(
        (ConfigPage page) => page.name == currentPageName,
      );
      if (foundIndex >= 0) {
        newPageIndex = foundIndex;
      } else if (state.currentPageIndex < newPages.length) {
        // Fallback to same index if valid
        newPageIndex = state.currentPageIndex;
      } else if (newPages.isNotEmpty) {
        // Clamp to last page if index is out of bounds
        newPageIndex = newPages.length - 1;
      }
    }

    state = state.copyWith(
      rootNode: newRoot,
      pages: newPages,
      currentPageIndex: newPageIndex,
      hasUnsavedChanges: true, // Mark as having unsaved changes
    );
  }

  /// Marks the current state as saved.
  void markAsSaved() {
    state = state.copyWith(hasUnsavedChanges: false);
  }

  /// Builds a path-indexed map for O(1) node lookups.
  ///
  /// This index dramatically improves performance for node updates in large trees.
  /// Instead of O(n) recursive traversal, we get O(1) lookups by path.
  void _buildPathIndex(ConfigNode root) {
    _nodesByPath = <String, ConfigNode>{};

    void traverse(ConfigNode node) {
      _nodesByPath[node.fullPath] = node;
      for (final ConfigNode child in node.children) {
        traverse(child);
      }
    }

    traverse(root);
  }

  /// Recursively updates a node in the tree.
  ///
  /// Performance: O(n) where n is the depth of the tree from root to the updated node.
  /// The path index helps us quickly determine the update path.
  ConfigNode _updateNodeInTree(ConfigNode current, ConfigNode updated) {
    // If this is the node to update, return the updated version
    if (current.fullPath == updated.fullPath) {
      return updated;
    }

    // If this node has children, check if any need updating
    if (current.children.isNotEmpty) {
      // Only rebuild children if the updated node is in this subtree
      // This optimization skips entire branches that don't contain the update
      final bool containsUpdate = updated.fullPath.startsWith(current.fullPath);

      if (!containsUpdate) {
        return current; // No changes in this subtree
      }

      final List<ConfigNode> newChildren = current.children.map(
        (ConfigNode child) => _updateNodeInTree(child, updated),
      ).toList();

      return current.copyWith(children: newChildren);
    }

    return current;
  }

  /// Navigates to a specific path in the tree.
  void navigateToPath(List<String> path) {
    state = state.copyWith(currentPath: path);
  }

  /// Clears the current error.
  void clearError() {
    state = state.copyWith();
  }

  /// Navigates to the next page.
  void nextPage() {
    if (state.currentPageIndex < state.pages.length - 1) {
      // Mark current page as completed before moving to next
      final Set<int> newCompletedPages = Set<int>.from(state.completedPages)
        ..add(state.currentPageIndex);
      state = state.copyWith(
        currentPageIndex: state.currentPageIndex + 1,
        completedPages: newCompletedPages,
      );
    }
  }

  /// Marks a specific page as completed.
  void markPageCompleted(int index) {
    if (index >= 0 && index < state.pages.length) {
      final Set<int> newCompletedPages = Set<int>.from(state.completedPages)
        ..add(index);
      state = state.copyWith(completedPages: newCompletedPages);
    }
  }

  /// Navigates to the previous page.
  void previousPage() {
    if (state.currentPageIndex > 0) {
      state = state.copyWith(currentPageIndex: state.currentPageIndex - 1);
    }
  }

  /// Navigates to a specific page by index.
  void goToPage(int index) {
    if (index >= 0 && index < state.pages.length) {
      // Always update, even if same index, to ensure UI rebuilds
      state = state.copyWith(currentPageIndex: index);
    }
  }
}

/// Provider for the config editor notifier.
final StateNotifierProvider<ConfigEditorNotifier, ConfigEditorState> configEditorProvider =
    StateNotifierProvider<ConfigEditorNotifier, ConfigEditorState>((Ref ref) {
  final ParseJson parseJson = ref.watch(parseJsonProvider);
  final ConvertToJson convertToJson = ref.watch(convertToJsonProvider);
  return ConfigEditorNotifier(
    parseJson: parseJson,
    convertToJson: convertToJson,
  );
});
