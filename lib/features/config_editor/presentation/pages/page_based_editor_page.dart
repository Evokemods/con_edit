import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/shortcuts/app_shortcuts.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/logger.dart';
import '../../../config_editor/data/repositories/config_repository_impl.dart';
import '../../../config_editor/domain/usecases/parse_json.dart';
import '../../../file_management/data/repositories/file_repository_impl.dart';
import '../../../file_management/presentation/providers/file_dialog_provider.dart';
import '../../../metadata_management/data/datasources/metadata_dao.dart';
import '../../../metadata_management/data/repositories/metadata_repository_impl.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../metadata_management/domain/usecases/config_training_system.dart';
import '../../../metadata_management/domain/usecases/extract_config_metadata.dart';
import '../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../pattern_recognition/data/datasources/pattern_dao.dart';
import '../../../pattern_recognition/data/repositories/pattern_repository_impl.dart';
import '../../../pattern_recognition/domain/usecases/analyze_configs.dart';
import '../../../pattern_recognition/presentation/providers/analyze_configs_provider.dart';
import '../../domain/entities/config_node.dart';
import '../../domain/entities/config_page.dart';
import '../providers/command_history_provider.dart';
import '../providers/config_provider.dart';
import '../providers/search_provider.dart';
import '../widgets/base_widgets/config_node_widget.dart';
import '../widgets/metadata_provider_widget.dart';
import '../widgets/search_dialog.dart';

/// Page-based config editor with sidebar navigation.
class PageBasedEditorPage extends ConsumerStatefulWidget {
  /// Creates a new PageBasedEditorPage.
  const PageBasedEditorPage({super.key});

  @override
  ConsumerState<PageBasedEditorPage> createState() =>
      _PageBasedEditorPageState();
}

class _PageBasedEditorPageState extends ConsumerState<PageBasedEditorPage> {
  static const Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.keyS, control: true): SaveIntent(),
    SingleActivator(LogicalKeyboardKey.keyO, control: true): OpenIntent(),
    SingleActivator(LogicalKeyboardKey.keyZ, control: true): UndoIntent(),
    SingleActivator(LogicalKeyboardKey.keyY, control: true): RedoIntent(),
    SingleActivator(LogicalKeyboardKey.keyF, control: true): SearchIntent(),
  };

  @override
  Widget build(BuildContext context) {
    final ConfigEditorState state = ref.watch(configEditorProvider);
    final CommandHistoryState commandHistory = ref.watch(
      commandHistoryProvider,
    );
    final FileDialogService fileDialog = ref.read(fileDialogProvider);

    return PopScope(
      canPop: !state.hasUnsavedChanges,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        if (state.hasUnsavedChanges) {
          final bool? shouldPop = await _showUnsavedChangesDialog(context);
          if (shouldPop == true && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Shortcuts(
      shortcuts: _shortcuts,
      child: Actions(
        actions: <Type, Action<Intent>>{
          SaveIntent: CallbackAction<SaveIntent>(
            onInvoke: (SaveIntent _) => _handleSave(),
          ),
          OpenIntent: CallbackAction<OpenIntent>(
            onInvoke: (OpenIntent _) => _handleOpen(fileDialog),
          ),
          UndoIntent: CallbackAction<UndoIntent>(
            onInvoke: (UndoIntent _) => _handleUndo(),
          ),
          RedoIntent: CallbackAction<RedoIntent>(
            onInvoke: (RedoIntent _) => _handleRedo(),
          ),
          SearchIntent: CallbackAction<SearchIntent>(
            onInvoke: (SearchIntent _) => _handleSearch(),
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Config Editor'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.folder_open),
                  tooltip: 'Open (Ctrl+O)',
                  onPressed: () => _handleOpen(fileDialog),
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'Save (Ctrl+S)',
                  onPressed: _handleSave,
                ),
                IconButton(
                  icon: const Icon(Icons.undo),
                  tooltip: 'Undo (Ctrl+Z)',
                  onPressed: commandHistory.canUndo ? _handleUndo : null,
                ),
                IconButton(
                  icon: const Icon(Icons.redo),
                  tooltip: 'Redo (Ctrl+Y)',
                  onPressed: commandHistory.canRedo ? _handleRedo : null,
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search (Ctrl+F)',
                  onPressed: _handleSearch,
                ),
                IconButton(
                  icon: const Icon(Icons.analytics),
                  tooltip: 'Analyze Configs',
                  onPressed: _handleAnalyzeConfigs,
                ),
                IconButton(
                  icon: const Icon(Icons.school),
                  tooltip: 'Train on Configs',
                  onPressed: _handleTrainConfigs,
                ),
              ],
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                    ? _buildErrorView(state, fileDialog)
                    : state.rootNode == null
                        ? _EmptyStateWidget(
                            onOpenFile: () => _handleOpen(fileDialog),
                          )
                        : _buildEditorView(state),
          ),
        ),
      ),
    ),
    );
  }

  /// Shows dialog for unsaved changes confirmation.
  Future<bool?> _showUnsavedChangesDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Row(
          children: <Widget>[
            Icon(
              Icons.warning_amber_rounded,
              color: DesignTokens.warningColor,
              size: 28,
            ),
            SizedBox(width: DesignTokens.space200),
            Text('Unsaved Changes'),
          ],
        ),
        content: const Text(
          'You have unsaved changes that will be lost. Do you want to save before leaving?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Discard',
              style: TextStyle(color: DesignTokens.errorColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await _handleSave();
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(true);
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Save & Exit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DesignTokens.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(
    ConfigEditorState state,
    FileDialogService fileDialog,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: DesignTokens.space200),
          Text(state.error!, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: DesignTokens.space200),
          ElevatedButton(
            onPressed: () => _handleOpen(fileDialog),
            child: const Text('Open File'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorView(ConfigEditorState state) {
    if (state.pages.isEmpty) {
      return const Center(child: Text('No configuration sections found'));
    }

    final ConfigPage? currentPage = state.currentPage;
    final double progress = (state.currentPageIndex + 1) / state.pages.length;

    return Row(
      children: <Widget>[
        // Sidebar Navigation
        _buildSidebar(state, progress),

        // Main Content Area
        Expanded(
          child: Column(
            children: <Widget>[
              // Current Page Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(DesignTokens.space400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Page Header
                      _buildPageHeader(currentPage, state),
                      const SizedBox(height: DesignTokens.space400),

                      // Page Content
                      if (currentPage != null)
                        _buildPageContent(currentPage, state),
                    ],
                  ),
                ),
              ),

              // Navigation Footer
              _buildNavigationFooter(state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar(ConfigEditorState state, double progress) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: DesignTokens.surfaceColor,
        border: Border(right: BorderSide(color: DesignTokens.dividerColor)),
      ),
      child: Column(
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.all(DesignTokens.space300),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: DesignTokens.dividerColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Configuration Sections',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: DesignTokens.space100),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: DesignTokens.dividerColor,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    DesignTokens.primaryColor,
                  ),
                ),
                const SizedBox(height: DesignTokens.space50),
                Text(
                  '${state.currentPageIndex + 1} of ${state.pages.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                ),
              ],
            ),
          ),

          // Page List
          Expanded(
            child: ListView.builder(
              itemCount: state.pages.length,
              itemBuilder: (BuildContext context, int index) {
                final ConfigPage page = state.pages[index];
                final bool isActive = index == state.currentPageIndex;
                final bool isCompleted = state.completedPages.contains(index);
                final bool isNext = index == state.currentPageIndex + 1;

                return ListTile(
                  selected: isActive,
                  selectedTileColor: DesignTokens.primaryColor.withValues(
                    alpha: 0.1,
                  ),
                  leading: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green
                          : isActive
                              ? DesignTokens.primaryColor
                              : DesignTokens.surfaceColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive || isCompleted
                            ? isCompleted
                                ? Colors.green
                                : DesignTokens.primaryColor
                            : DesignTokens.dividerColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                const Icon(
                                  Icons.check_circle,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                Positioned(
                                  bottom: -2,
                                  right: -2,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.green,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              height: 1.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : isNext
                              ? Text(
                                  'Next',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: DesignTokens.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                      ),
                                )
                              : Text(
                                  '${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: isActive
                                            ? Colors.white
                                            : DesignTokens.onSurfaceVariantColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                    ),
                  ),
                  title: Text(
                    page.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive
                              ? DesignTokens.primaryColor
                              : DesignTokens.onSurfaceColor,
                        ),
                  ),
                  subtitle: page.description != null
                      ? Text(
                          page.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: DesignTokens.onSurfaceVariantColor,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () {
                    ref.read(configEditorProvider.notifier).goToPage(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds page content with pre-computed metadata for performance.
  ///
  /// Pre-computes metadata lookup for all nodes on the page to avoid
  /// N+1 provider watches (one watch per widget). This improves performance
  /// significantly for pages with many fields.
  Widget _buildPageContent(ConfigPage currentPage, ConfigEditorState state) {
    // Pre-compute metadata for all nodes on this page
    final Map<String, FieldMetadata> metadataMap = <String, FieldMetadata>{};

    if (state.currentFilePath != null && state.currentFilePath!.isNotEmpty) {
      // Get the metadata cache for the current file
      final Map<String, List<FieldMetadata>> cache = ref.watch(
        configMetadataCacheProvider(state.currentFilePath!),
      );

      // Build metadata map for all nodes on this page
      void collectMetadata(ConfigNode node) {
        final String fieldPath = node.path.join('.');
        final List<FieldMetadata>? metadataList = cache[fieldPath];

        if (metadataList != null && metadataList.isNotEmpty) {
          // Store the highest confidence metadata
          metadataList.sort((FieldMetadata a, FieldMetadata b) =>
              b.confidence.compareTo(a.confidence));
          metadataMap[fieldPath] = metadataList.first;
        }

        // Recursively collect for children
        for (final ConfigNode child in node.children) {
          collectMetadata(child);
        }
      }

      // Collect metadata for all nodes
      for (final ConfigNode node in currentPage.nodes) {
        collectMetadata(node);
      }

      // Debug logging
      debugPrint('📦 PAGE METADATA: Collected ${metadataMap.length} metadata entries');
      if (metadataMap.keys.any((String k) => k.toLowerCase().contains('short'))) {
        debugPrint('   - Shortname fields found:');
        metadataMap.keys.where((String k) => k.toLowerCase().contains('short')).forEach((String k) {
          debugPrint('     • $k');
        });
      }
    }

    // Build widgets with pre-computed metadata
    // Wrap in MetadataProvider so nested widgets can access metadata
    return MetadataProvider(
      metadataMap: metadataMap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: currentPage.nodes.map(
          (ConfigNode node) => Padding(
            padding: const EdgeInsets.only(
              bottom: DesignTokens.space300,
            ),
            child: ConfigNodeWidget(
              node: node,
              metadata: metadataMap[node.path.join('.')],
              onNodeChanged: (ConfigNode updatedNode) {
                ref
                    .read(configEditorProvider.notifier)
                    .updateNode(updatedNode);
              },
            ),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildPageHeader(ConfigPage? currentPage, ConfigEditorState state) {
    if (currentPage == null) return const SizedBox.shrink();

    // Extract plugin name from file path
    String? pluginName;
    if (state.currentFilePath != null) {
      final String fileName = state.currentFilePath!
          .split('/')
          .last
          .split('\\')
          .last;
      if (fileName.endsWith('.json')) {
        pluginName = fileName.substring(0, fileName.length - 5);
      } else {
        pluginName = fileName;
      }
    }

    return Row(
      children: <Widget>[
        const Icon(
          Icons.folder_open,
          color: DesignTokens.primaryColor,
          size: 32,
        ),
        const SizedBox(width: DesignTokens.space200),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Plugin name badge
              if (pluginName != null) ...<Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.space150,
                    vertical: DesignTokens.space50,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
                    border: Border.all(
                      color: DesignTokens.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.extension,
                        size: 16,
                        color: DesignTokens.primaryColor,
                      ),
                      const SizedBox(width: DesignTokens.space100),
                      Text(
                        pluginName,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: DesignTokens.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DesignTokens.space200),
              ],
              Text(
                currentPage.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (currentPage.description != null) ...<Widget>[
                const SizedBox(height: DesignTokens.space50),
                Text(
                  currentPage.description!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationFooter(ConfigEditorState state) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.space300),
      decoration: const BoxDecoration(
        color: DesignTokens.surfaceColor,
        border: Border(top: BorderSide(color: DesignTokens.dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Back Button
          OutlinedButton.icon(
            onPressed: state.currentPageIndex > 0
                ? () => ref.read(configEditorProvider.notifier).previousPage()
                : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
          ),

          // Progress Text
          Text(
            'Section ${state.currentPageIndex + 1} of ${state.pages.length}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: DesignTokens.onSurfaceVariantColor,
                ),
          ),

          // Next/Finish Button
          state.currentPageIndex < state.pages.length - 1
              ? ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(configEditorProvider.notifier).nextPage(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                )
              : ElevatedButton.icon(
                  onPressed: _handleSave,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Finish & Save'),
                ),
        ],
      ),
    );
  }

  Future<void> _handleOpen(FileDialogService fileDialog) async {
    final FileDialogResult? result = await fileDialog.pickAndOpenFile();
    if (result != null && result.success && result.content != null) {
      await ref
          .read(configEditorProvider.notifier)
          .loadFromJson(result.content!, filePath: result.filePath);
      
      // Trigger metadata extraction in background after config is loaded
      final ConfigEditorState state = ref.read(configEditorProvider);
      if (state.rootNode != null && result.filePath != null) {
        // Extract metadata asynchronously (non-blocking)
        Future<void>.microtask(() async {
          final ConfigMetadataCacheNotifier cacheNotifier = ref.read(
            configMetadataCacheProvider(result.filePath!).notifier,
          );
          await cacheNotifier.extractAndCache(state.rootNode!);
        });
      }
    } else if (result != null && !result.success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.error ?? 'Failed to open file')),
        );
      }
    }
  }

  Future<void> _handleSave() async {
    final ConfigEditorState state = ref.read(configEditorProvider);
    if (state.rootNode == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No config to save')));
      }
      return;
    }

    final String? jsonString = await ref
        .read(configEditorProvider.notifier)
        .toJsonString();

    if (jsonString != null) {
      final FileDialogService fileDialog = ref.read(fileDialogProvider);
      final FileDialogResult? result = await fileDialog.pickAndSaveFile(
        jsonString,
      );
      if (result != null && result.success) {
        // Mark as saved after successful save
        ref.read(configEditorProvider.notifier).markAsSaved();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File saved successfully')),
          );
        }
      } else if (result != null && !result.success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.error ?? 'Failed to save file')),
          );
        }
      }
    }
  }

  void _handleUndo() {
    final ConfigEditorState state = ref.read(configEditorProvider);
    if (state.rootNode == null) return;

    final CommandHistoryNotifier commandHistory = ref.read(
      commandHistoryProvider.notifier,
    );
    final ConfigNode? newRoot = commandHistory.undo(state.rootNode!);
    if (newRoot != null) {
      ref.read(configEditorProvider.notifier).updateNode(newRoot);
    }
  }

  void _handleRedo() {
    final ConfigEditorState state = ref.read(configEditorProvider);
    if (state.rootNode == null) return;

    final CommandHistoryNotifier commandHistory = ref.read(
      commandHistoryProvider.notifier,
    );
    final ConfigNode? newRoot = commandHistory.redo(state.rootNode!);
    if (newRoot != null) {
      ref.read(configEditorProvider.notifier).updateNode(newRoot);
    }
  }

  void _handleSearch() {
    ref.read(searchProvider.notifier).openSearch();
    showDialog<void>(
      context: context,
      builder: (BuildContext _) => const SearchDialog(),
    ).then((void _) {
      ref.read(searchProvider.notifier).closeSearch();
    });
  }

  Future<void> _handleAnalyzeConfigs() async {
    // Ask user to select config directory first
    final FileDialogService fileDialog = ref.read(fileDialogProvider);
    final FileDialogResult? directoryResult = await fileDialog.pickDirectory(
      dialogTitle: 'Select Config Directory to Analyze',
    );

    if (directoryResult == null || !directoryResult.success) {
      if (directoryResult?.error != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(directoryResult!.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return; // User cancelled or error occurred
    }

    final String? configDirectory = directoryResult.filePath;
    if (configDirectory == null) {
      return; // No directory selected
    }

    final AnalyzeConfigs analyzeConfigs = ref.read(analyzeConfigsProvider);
    final PatternRepositoryImpl patternRepository =
        ref.read(patternRepositoryProvider);

    // Show progress dialog
    if (!mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _AnalysisProgressDialog(),
    );

    // Clear existing patterns first
    final Either<Failure, void> clearResult =
        await patternRepository.clearAllPatterns();
    clearResult.fold(
      (Failure failure) {
        Logger.error(
          'Failed to clear patterns',
          error: failure.message,
          name: 'PageBasedEditorPage',
        );
      },
      (void _) {
        Logger.info(
          'Cleared all existing patterns',
          name: 'PageBasedEditorPage',
        );
      },
    );

    // Run analysis on selected directory
    final Either<Failure, int> result =
        await analyzeConfigs.analyzeDirectory(configDirectory);

    if (!mounted) return;
    Navigator.of(context).pop(); // Close progress dialog

    result.fold(
      (Failure failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Analysis failed: ${failure.message ?? 'Unknown error'}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (int totalPatterns) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Analysis complete! Found and saved $totalPatterns unique patterns.',
            ),
            backgroundColor: DesignTokens.primaryColor,
          ),
        );
      },
    );
  }

  Future<void> _handleTrainConfigs() async {
    // Ask user to select config directory first
    final FileDialogService fileDialog = ref.read(fileDialogProvider);
    final FileDialogResult? directoryResult = await fileDialog.pickDirectory(
      dialogTitle: 'Select Config Directory to Train On',
    );

    if (directoryResult == null || !directoryResult.success) {
      if (directoryResult?.error != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(directoryResult!.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return; // User cancelled or error occurred
    }

    final String? configDirectory = directoryResult.filePath;
    if (configDirectory == null) {
      return; // No directory selected
    }

    // Show progress dialog
    if (!mounted) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _TrainingProgressDialog(),
    );

    try {
      // Initialize database and repositories
      final AppDatabase database = AppDatabase();
      final MetadataDao metadataDao = MetadataDao(database);
      final PatternDao patternDao = PatternDao(database);
      const ConfigRepositoryImpl configRepository = ConfigRepositoryImpl();
      const FileRepositoryImpl fileRepository = FileRepositoryImpl();
      final PatternRepositoryImpl patternRepository = PatternRepositoryImpl(
        patternDao,
        metadataDao,
      );
      final MetadataRepositoryImpl metadataRepository = MetadataRepositoryImpl(
        fileRepository,
        metadataDao,
        patternRepository: patternRepository,
      );

      // Initialize use cases
      const ParseJson parseJson = ParseJson(configRepository);
      final ExtractConfigMetadata extractMetadata = ExtractConfigMetadata();
      final ConfigTrainingSystem trainingSystem = ConfigTrainingSystem(
        parseJson: parseJson,
        extractMetadata: extractMetadata,
        metadataRepository: metadataRepository,
      );

      // Run training on selected directory
      final Either<Failure, TrainingResult> result =
          await trainingSystem.trainOnDirectory(configDirectory);

      await database.close();

      if (!mounted) return;
      Navigator.of(context).pop(); // Close progress dialog

      result.fold(
        (Failure failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Training failed: ${failure.message ?? 'Unknown error'}',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
        (TrainingResult trainingResult) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Training complete! Processed ${trainingResult.processedPlugins.length} plugins, '
                '${trainingResult.totalFields} fields, '
                '${trainingResult.totalMetadata} metadata entries.',
              ),
              backgroundColor: DesignTokens.primaryColor,
              duration: const Duration(seconds: 5),
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error during training',
        error: e,
        stackTrace: stackTrace,
        name: 'PageBasedEditorPage',
      );
      if (mounted) {
        Navigator.of(context).pop(); // Close progress dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Training error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

/// Progress dialog for training.
class _TrainingProgressDialog extends StatelessWidget {
  const _TrainingProgressDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: DesignTokens.space200),
          Text(
            'Training on config files...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: DesignTokens.space100),
          Text(
            'Analyzing all configs and extracting metadata.\n'
            'This may take a moment.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: DesignTokens.onSurfaceVariantColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Empty state widget with hover effects.
class _EmptyStateWidget extends StatefulWidget {
  /// Creates a new _EmptyStateWidget.
  const _EmptyStateWidget({required this.onOpenFile});

  /// Callback when user wants to open a file.
  final VoidCallback onOpenFile;

  @override
  State<_EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<_EmptyStateWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            DesignTokens.backgroundColor,
            DesignTokens.surfaceVariantColor,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo/Title
              const Icon(
                Icons.settings_input_component,
                size: 80,
                color: DesignTokens.primaryColor,
              ),
              const SizedBox(height: DesignTokens.space300),
              Text(
                'CONEDIT - CONFIG EDITOR',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: DesignTokens.primaryColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: DesignTokens.space100),
              Text(
                'Universal config editor for Rust plugin JSON files',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: DesignTokens.onSurfaceVariantColor,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.space500),

              // Drop Zone with hover effect
              MouseRegion(
                onEnter: (PointerEvent _) => setState(() => _isHovering = true),
                onExit: (PointerEvent _) => setState(() => _isHovering = false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onOpenFile,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(DesignTokens.space500),
                    decoration: BoxDecoration(
                      color: DesignTokens.surfaceColor,
                      borderRadius:
                          BorderRadius.circular(DesignTokens.radiusLarge),
                      border: Border.all(
                        color: DesignTokens.primaryColor,
                        width: _isHovering ? 3 : 2,
                      ),
                      boxShadow: _isHovering
                          ? <BoxShadow>[
                              BoxShadow(
                                color: DesignTokens.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.upload_file,
                          size: 64,
                          color: DesignTokens.primaryColor,
                        ),
                        const SizedBox(height: DesignTokens.space300),
                        Text(
                          'Click to Select JSON Config',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: DesignTokens.onSurfaceColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: DesignTokens.space100),
                        Text(
                          'Supports Ctrl+O shortcut',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: DesignTokens.onSurfaceVariantColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.space400),

              // Supported formats
              Container(
                padding: const EdgeInsets.all(DesignTokens.space200),
                decoration: BoxDecoration(
                  color: DesignTokens.surfaceVariantColor.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(DesignTokens.radiusMedium),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: DesignTokens.primaryColor,
                    ),
                    const SizedBox(width: DesignTokens.space100),
                    Text(
                      'Supports JSON config files from Rust plugins',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: DesignTokens.onSurfaceVariantColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dialog showing analysis progress.
class _AnalysisProgressDialog extends StatelessWidget {
  /// Creates a new _AnalysisProgressDialog.
  const _AnalysisProgressDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: DesignTokens.space300),
          Text(
            'Analyzing config files...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: DesignTokens.space100),
          Text(
            'This may take a few moments.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
