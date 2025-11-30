import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/config_node.dart';
import '../providers/config_provider.dart';
import '../providers/search_provider.dart';

/// Search dialog widget.
class SearchDialog extends ConsumerStatefulWidget {
  /// Creates a new SearchDialog.
  const SearchDialog({super.key});

  @override
  ConsumerState<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends ConsumerState<SearchDialog> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchState searchState = ref.watch(searchProvider);
    final ConfigEditorState configState = ref.watch(configEditorProvider);

    return Dialog(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.search),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String query) {
                      ref.read(searchProvider.notifier).search(
                            configState.rootNode,
                            query,
                          );
                    },
                    onSubmitted: (String _) {
                      if (searchState.hasResults) {
                        ref.read(searchProvider.notifier).nextResult();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    ref.read(searchProvider.notifier).closeSearch();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            if (searchState.query.isNotEmpty) ...<Widget>[
              const SizedBox(height: AppDimensions.spacingMedium),
              if (searchState.hasResults)
                Text(
                  '${searchState.results.length} result(s) - '
                  '${searchState.selectedIndex + 1} of ${searchState.results.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              else
                Text(
                  'No results found',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              if (searchState.hasResults) ...<Widget>[
                const SizedBox(height: AppDimensions.spacingSmall),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () {
                        ref.read(searchProvider.notifier).previousResult();
                      },
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text('Previous'),
                    ),
                    const SizedBox(width: AppDimensions.spacingSmall),
                    TextButton.icon(
                      onPressed: () {
                        ref.read(searchProvider.notifier).nextResult();
                      },
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text('Next'),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spacingSmall),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchState.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ConfigNode node = searchState.results[index];
                      final bool isSelected = index == searchState.selectedIndex;
                      return ListTile(
                        selected: isSelected,
                        title: Text(node.key ?? '[${node.path.last}]'),
                        subtitle: Text(
                          node.path.join(' > '),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        onTap: () {
                          ref.read(searchProvider.notifier).setSelectedIndex(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

