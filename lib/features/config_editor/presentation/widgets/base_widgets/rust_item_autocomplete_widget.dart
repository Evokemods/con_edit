import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/services/rust_items_service.dart';
import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../domain/entities/config_node.dart';
import '../field_label_with_help.dart';

/// Autocomplete widget for Rust item shortnames.
///
/// Searches through the Rust items database and provides suggestions
/// with display names, categories, and shortnames.
class RustItemAutocompleteWidget extends ConsumerStatefulWidget {
  /// Creates a new RustItemAutocompleteWidget.
  const RustItemAutocompleteWidget({
    required this.node,
    required this.onChanged,
    super.key,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<String> onChanged;

  @override
  ConsumerState<RustItemAutocompleteWidget> createState() =>
      _RustItemAutocompleteWidgetState();
}

class _RustItemAutocompleteWidgetState
    extends ConsumerState<RustItemAutocompleteWidget> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _keyboardListenerFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  List<RustItem> _suggestions = <RustItem>[];
  bool _isLoading = false;
  int _selectedIndex = -1;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.node.value?.toString() ?? '',
    );
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    _keyboardListenerFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RustItemAutocompleteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller if not currently focused (user isn't typing)
    if (!_focusNode.hasFocus && oldWidget.node.value != widget.node.value) {
      _controller.text = widget.node.value?.toString() ?? '';
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && _controller.text.isNotEmpty) {
      _searchItems(_controller.text);
    } else {
      _removeOverlay();
      // Save value when focus is lost
      if (_controller.text != widget.node.value?.toString()) {
        widget.onChanged(_controller.text);
      }
    }
  }

  void _searchItems(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        _isLoading = false;
        _suggestions = <RustItem>[];
      });
      _removeOverlay();
      return;
    }

    // Set loading immediately
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    // Debounce: wait 300ms before actually searching
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final List<RustItem> items =
            await RustItemsService.instance.searchItems(query);

        if (mounted) {
          setState(() {
            _suggestions = items.take(10).toList(); // Limit to 10 results
            _isLoading = false;
            _selectedIndex = -1;
          });

          if (_suggestions.isNotEmpty) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _suggestions = <RustItem>[];
          });
        }
      }
    });
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        width: _getTextFieldWidth(),
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, _getTextFieldHeight() + 4),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            color: DesignTokens.surfaceColor,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: _buildSuggestionsList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildSuggestionsList() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.dividerColor),
        borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          final RustItem item = _suggestions[index];
          final bool isSelected = index == _selectedIndex;

          return Material(
            color: isSelected
                ? DesignTokens.primaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
            child: InkWell(
              onTap: () => _selectItem(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.space200,
                  vertical: DesignTokens.space150,
                ),
                child: Row(
                  children: <Widget>[
                    // Item icon (if available)
                    if (item.imageUrl != null) ...<Widget>[
                      _buildItemIcon(item.imageUrl!),
                      const SizedBox(width: DesignTokens.space150),
                    ],

                    // Category badge
                    _buildCategoryBadge(item.category),
                    const SizedBox(width: DesignTokens.space150),

                    // Item info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Display name
                          Text(
                            item.displayName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: DesignTokens.space50),
                          // Shortname
                          Text(
                            item.shortname,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: DesignTokens.onSurfaceVariantColor,
                                  fontFamily: 'Courier',
                                ),
                          ),
                        ],
                      ),
                    ),

                    // Selection indicator
                    if (isSelected)
                      const Icon(
                        Icons.keyboard_return,
                        size: 16,
                        color: DesignTokens.primaryColor,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemIcon(String imageUrl) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: DesignTokens.backgroundColor,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
        border: Border.all(
          color: DesignTokens.dividerColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
        child: FutureBuilder<Uint8List?>(
          future: _loadImageBytes(imageUrl),
          builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return const Icon(
                      Icons.inventory_2_outlined,
                      size: 16,
                      color: DesignTokens.onSurfaceVariantColor,
                    );
                  },
                );
              } else {
                return const Icon(
                  Icons.inventory_2_outlined,
                  size: 16,
                  color: DesignTokens.onSurfaceVariantColor,
                );
              }
            } else {
              return const Center(
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      DesignTokens.primaryColor,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Uint8List?> _loadImageBytes(String imageUrl) async {
    try {
      final http.Response response = await http
          .get(Uri.parse(imageUrl))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      debugPrint('Failed to load item icon: $imageUrl - $e');
      return null;
    }
  }

  Widget _buildCategoryBadge(String category) {
    final Color badgeColor = _getCategoryColor(category);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.space100,
        vertical: DesignTokens.space50,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: badgeColor,
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'weapon':
        return const Color(0xFFef4444); // Red
      case 'resource':
        return const Color(0xFF10b981); // Green
      case 'medical':
        return const Color(0xFF06b6d4); // Cyan
      case 'food':
        return const Color(0xFFf59e0b); // Yellow
      case 'deployable':
        return const Color(0xFF8b5cf6); // Purple
      case 'building':
        return const Color(0xFF6b7280); // Gray
      case 'storage':
        return const Color(0xFF3b82f6); // Blue
      case 'ammo':
        return const Color(0xFFf97316); // Orange
      default:
        return DesignTokens.onSurfaceVariantColor;
    }
  }

  void _selectItem(RustItem item) {
    _controller.text = item.shortname;
    widget.onChanged(item.shortname);
    _removeOverlay();
    _focusNode.unfocus();
  }

  void _handleKeyPress(KeyEvent event) {
    if (_suggestions.isEmpty) return;

    if (event.logicalKey.keyLabel == 'Arrow Down') {
      setState(() {
        _selectedIndex = (_selectedIndex + 1) % _suggestions.length;
      });
      _showOverlay(); // Refresh overlay
    } else if (event.logicalKey.keyLabel == 'Arrow Up') {
      setState(() {
        _selectedIndex = (_selectedIndex - 1) % _suggestions.length;
        if (_selectedIndex < 0) _selectedIndex = _suggestions.length - 1;
      });
      _showOverlay(); // Refresh overlay
    } else if (event.logicalKey.keyLabel == 'Enter') {
      if (_selectedIndex >= 0 && _selectedIndex < _suggestions.length) {
        _selectItem(_suggestions[_selectedIndex]);
      }
    } else if (event.logicalKey.keyLabel == 'Escape') {
      _removeOverlay();
      _focusNode.unfocus();
    }
  }

  double _getTextFieldWidth() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.width ?? 300;
  }

  double _getTextFieldHeight() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 48;
  }

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.node.key != null) ...<Widget>[
            Builder(
              builder: (BuildContext context) {
                // Get metadata for help
                final String fieldPath = widget.node.path.join('.');
                final FieldMetadata? metadata = ref.watch(
                  fieldMetadataProvider(fieldPath),
                );

                return FieldLabelWithHelp(
                  label: widget.node.key!,
                  metadata: metadata,
                );
              },
            ),
            const SizedBox(height: DesignTokens.space100),
          ],
          CompositedTransformTarget(
            link: _layerLink,
            child: KeyboardListener(
              focusNode: _keyboardListenerFocusNode,
              onKeyEvent: _handleKeyPress,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search Rust items (e.g., "rifle.ak", "wood")',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                  prefixIcon: _isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(DesignTokens.space200),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                DesignTokens.primaryColor,
                              ),
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.search,
                          color: DesignTokens.onSurfaceVariantColor,
                        ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 18,
                            color: DesignTokens.onSurfaceVariantColor,
                          ),
                          onPressed: () {
                            _controller.clear();
                            widget.onChanged('');
                            _removeOverlay();
                          },
                        )
                      : null,
                ),
                onChanged: (String value) {
                  _searchItems(value);
                },
              ),
            ),
          ),

          // Info text
          if (_controller.text.isEmpty)
            Padding(
                  padding: const EdgeInsets.only(top: DesignTokens.space100),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.info_outline,
                    size: 14,
                    color: DesignTokens.onSurfaceVariantColor,
                  ),
                  const SizedBox(width: DesignTokens.space50),
                  Expanded(
                    child: Text(
                      'Type to search from 350+ Rust items',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: DesignTokens.onSurfaceVariantColor,
                            fontSize: 11,
                          ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
