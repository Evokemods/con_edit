import 'package:flutter/material.dart';

import '../../../../../../core/services/rust_items_service.dart';
import '../../../../../../core/theme/design_tokens.dart';

/// Specialized input widget for Rust item arrays with autocomplete.
class ItemArrayInput extends StatefulWidget {
  /// Creates a new ItemArrayInput.
  const ItemArrayInput({
    required this.onAdd,
    this.hintText,
    super.key,
  });

  /// Callback when user wants to add an item.
  final ValueChanged<String> onAdd;

  /// Optional hint text.
  final String? hintText;

  @override
  State<ItemArrayInput> createState() => _ItemArrayInputState();
}

class _ItemArrayInputState extends State<ItemArrayInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final RustItemsService _itemsService = RustItemsService.instance;
  List<RustItem> _searchResults = <RustItem>[];
  bool _isSearching = false;
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _searchItems(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = <RustItem>[];
        _showDropdown = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _showDropdown = true;
    });

    try {
      final List<RustItem> results = await _itemsService.searchItems(query);
      if (mounted) {
        setState(() {
          _searchResults = results.take(10).toList();
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _searchResults = <RustItem>[];
        });
      }
    }
  }

  void _handleAdd([String? value]) {
    final String itemValue = value ?? _controller.text.trim();
    if (itemValue.isEmpty) return;

    widget.onAdd(itemValue);
    _controller.clear();
    _focusNode.requestFocus();

    setState(() {
      _searchResults = <RustItem>[];
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText ??
                      'Search Rust items... (e.g., "campfire", "ak")',
                  isDense: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? const Padding(
                          padding: EdgeInsets.all(DesignTokens.space100),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: DesignTokens.primaryColor,
                            ),
                          ),
                        )
                      : _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _controller.clear();
                                setState(() {
                                  _searchResults = <RustItem>[];
                                  _showDropdown = false;
                                });
                              },
                            )
                          : null,
                ),
                onChanged: _searchItems,
                onSubmitted: (String _) => _handleAdd(),
                onTap: () {
                  if (_controller.text.isNotEmpty && _searchResults.isNotEmpty) {
                    setState(() {
                      _showDropdown = true;
                    });
                  }
                },
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(width: DesignTokens.space100),
            ElevatedButton.icon(
              onPressed: _controller.text.trim().isNotEmpty ? _handleAdd : null,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),

        // Dropdown results - only show when there are results and dropdown is visible
        if (_showDropdown && _searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: DesignTokens.space100),
            decoration: BoxDecoration(
              color: DesignTokens.surfaceColor,
              borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
              border: Border.all(
                color: DesignTokens.primaryColor.withValues(alpha: 0.3),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 250),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                final RustItem item = _searchResults[index];
                return _ItemResultTile(
                  item: item,
                  onTap: () => _handleAdd(item.shortname),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Tile widget for displaying a search result item.
class _ItemResultTile extends StatelessWidget {
  const _ItemResultTile({
    required this.item,
    required this.onTap,
  });

  final RustItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: item.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
              child: Image.network(
                item.imageUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object error,
                  StackTrace? stackTrace,
                ) {
                  return const Icon(
                    Icons.inventory_2,
                    color: DesignTokens.primaryColor,
                    size: 24,
                  );
                },
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: DesignTokens.primaryColor,
                      ),
                    ),
                  );
                },
              ),
            )
          : const Icon(
              Icons.inventory_2,
              color: DesignTokens.primaryColor,
              size: 24,
            ),
      title: Text(
        item.displayName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        item.shortname,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: DesignTokens.primaryColor,
            ),
      ),
      trailing: Text(
        item.category,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: DesignTokens.onSurfaceVariantColor,
            ),
      ),
      onTap: onTap,
    );
  }
}

