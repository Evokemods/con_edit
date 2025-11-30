import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/config_node.dart';

/// State for search functionality.
class SearchState {
  /// Creates a new SearchState.
  const SearchState({
    this.query = '',
    this.isActive = false,
    this.results = const <ConfigNode>[],
    this.selectedIndex = 0,
  });

  /// Search query string.
  final String query;

  /// Whether search is currently active.
  final bool isActive;

  /// List of matching nodes.
  final List<ConfigNode> results;

  /// Currently selected result index.
  final int selectedIndex;

  /// Whether there are search results.
  bool get hasResults => results.isNotEmpty;

  /// Currently selected result.
  ConfigNode? get selectedResult =>
      hasResults && selectedIndex < results.length
          ? results[selectedIndex]
          : null;

  /// Creates a copy with updated fields.
  SearchState copyWith({
    String? query,
    bool? isActive,
    List<ConfigNode>? results,
    int? selectedIndex,
  }) {
    return SearchState(
      query: query ?? this.query,
      isActive: isActive ?? this.isActive,
      results: results ?? this.results,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

/// Notifier for search functionality.
class SearchNotifier extends StateNotifier<SearchState> {
  /// Creates a new SearchNotifier.
  SearchNotifier() : super(const SearchState());

  /// Opens the search dialog.
  void openSearch() {
    state = state.copyWith(isActive: true);
  }

  /// Closes the search dialog.
  void closeSearch() {
    state = const SearchState();
  }

  /// Updates the search query and performs search.
  void search(ConfigNode? rootNode, String query) {
    if (query.isEmpty || rootNode == null) {
      state = state.copyWith(query: query, results: <ConfigNode>[]);
      return;
    }

    final List<ConfigNode> results = _performSearch(rootNode, query.toLowerCase());
    state = state.copyWith(
      query: query,
      results: results,
      selectedIndex: 0,
    );
  }

  /// Moves to the next search result.
  void nextResult() {
    if (state.hasResults) {
      final int nextIndex = (state.selectedIndex + 1) % state.results.length;
      state = state.copyWith(selectedIndex: nextIndex);
    }
  }

  /// Moves to the previous search result.
  void previousResult() {
    if (state.hasResults) {
      final int prevIndex = state.selectedIndex == 0
          ? state.results.length - 1
          : state.selectedIndex - 1;
      state = state.copyWith(selectedIndex: prevIndex);
    }
  }

  /// Sets the selected result index.
  void setSelectedIndex(int index) {
    if (index >= 0 && index < state.results.length) {
      state = state.copyWith(selectedIndex: index);
    }
  }

  /// Performs recursive search on the config tree.
  List<ConfigNode> _performSearch(ConfigNode node, String query) {
    final List<ConfigNode> results = <ConfigNode>[];

    // Check if this node matches
    if (_nodeMatches(node, query)) {
      results.add(node);
    }

    // Search children
    for (final ConfigNode child in node.children) {
      results.addAll(_performSearch(child, query));
    }

    return results;
  }

  /// Checks if a node matches the search query.
  bool _nodeMatches(ConfigNode node, String query) {
    // Match by key
    if (node.key != null && node.key!.toLowerCase().contains(query)) {
      return true;
    }

    // Match by value (for primitive types)
    if (node.value != null) {
      final String valueString = node.value.toString().toLowerCase();
      if (valueString.contains(query)) {
        return true;
      }
    }

    return false;
  }
}

/// Provider for search functionality.
final StateNotifierProvider<SearchNotifier, SearchState> searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((Ref ref) {
  return SearchNotifier();
});

