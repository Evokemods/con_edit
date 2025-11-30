import 'package:flutter/material.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../metadata_management/domain/entities/widget_hint.dart';
import '../../../domain/entities/config_node.dart';
import '../../../domain/entities/config_value_type.dart';
import 'array_display_widgets/object_array_display.dart';
import 'array_display_widgets/primitive_array_display.dart';
import 'array_input_widgets/item_array_input.dart';
import 'array_input_widgets/number_array_input.dart';
import 'array_input_widgets/string_array_input.dart';
import 'array_type_detector.dart';

/// Widget for editing array values with context-aware UI.
class ArrayWidget extends StatefulWidget {
  /// Creates a new ArrayWidget.
  const ArrayWidget({
    super.key,
    required this.node,
    this.onNodeChanged,
    this.widgetHint,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when node changes.
  final ValueChanged<ConfigNode>? onNodeChanged;

  /// Widget hint for rendering options.
  final WidgetHint? widgetHint;

  @override
  State<ArrayWidget> createState() => _ArrayWidgetState();
}

class _ArrayWidgetState extends State<ArrayWidget> {
  /// Detected array type.
  late final ArrayType _arrayType;

  @override
  void initState() {
    super.initState();
    _arrayType = ArrayTypeDetector.detectArrayType(widget.node);
  }

  void _addItem(dynamic value) {
    final ConfigNode newChild = ConfigNode(
      key: null,
      valueType: _detectValueType(value),
      value: value,
      path: <String>[...widget.node.path, '[${widget.node.children.length}]'],
    );

    widget.onNodeChanged?.call(
      widget.node.copyWith(
        children: <ConfigNode>[...widget.node.children, newChild],
      ),
    );
  }

  void _addString(String value) {
    _addItem(value);
  }

  void _addNumber(num value) {
    _addItem(value);
  }

  void _removeItem(int index) {
    final List<ConfigNode> newChildren = List<ConfigNode>.from(
      widget.node.children,
    );
    newChildren.removeAt(index);
    widget.onNodeChanged?.call(widget.node.copyWith(children: newChildren));
  }

  void _updateItem(int index, ConfigNode updatedNode) {
    final List<ConfigNode> newChildren = List<ConfigNode>.from(
      widget.node.children,
    );
    newChildren[index] = updatedNode;
    widget.onNodeChanged?.call(widget.node.copyWith(children: newChildren));
  }

  ConfigValueType _detectValueType(dynamic value) {
    if (value is bool) return ConfigValueType.boolean;
    if (value is int) return ConfigValueType.integer;
    if (value is double) return ConfigValueType.double;
    if (value is String) return ConfigValueType.string;
    if (value is Map) return ConfigValueType.object;
    if (value is List) return ConfigValueType.array;
    return ConfigValueType.unknown;
  }

  bool get _isPrimitiveArray {
    if (widget.node.children.isEmpty) {
      // If empty, check detected type
      return _arrayType != ArrayType.objects && _arrayType != ArrayType.mixed;
    }
    return !widget.node.children.first.valueType.isCollection;
  }

  bool get _isObjectArray {
    if (widget.node.children.isEmpty) {
      return _arrayType == ArrayType.objects;
    }
    return widget.node.children.first.valueType == ConfigValueType.object;
  }

  Widget _buildInputWidget() {
    final String hintText = ArrayTypeDetector.getHintText(
      _arrayType,
      widget.node.key,
    );

    switch (_arrayType) {
      case ArrayType.rustItems:
        return ItemArrayInput(onAdd: _addString, hintText: hintText);

      case ArrayType.strings:
        return StringArrayInput(onAdd: _addString, hintText: hintText);

      case ArrayType.numbers:
        // Determine number type from existing items or default to double
        final ConfigValueType numberType =
            widget.node.children.isNotEmpty &&
                widget.node.children.first.valueType == ConfigValueType.integer
            ? ConfigValueType.integer
            : ConfigValueType.double;

        return NumberArrayInput(
          onAdd: _addNumber,
          hintText: hintText,
          valueType: numberType,
        );

      case ArrayType.objects:
        return ElevatedButton.icon(
          onPressed: () {
            // Add empty object
            final ConfigNode newObject = ConfigNode(
              key: null,
              valueType: ConfigValueType.object,
              value: const <String, dynamic>{},
              path: <String>[
                ...widget.node.path,
                '[${widget.node.children.length}]',
              ],
            );
            _addItem(newObject.value);
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Object'),
        );

      case ArrayType.booleans:
      case ArrayType.mixed:
        // Fallback to string input for mixed/unknown types
        return StringArrayInput(onAdd: _addString, hintText: hintText);
    }
  }

  Widget _buildDisplayWidget() {
    if (widget.node.children.isEmpty) {
      return const SizedBox.shrink(); // Empty state handled by display widgets
    }

    if (_isObjectArray) {
      return ObjectArrayDisplay(
        items: widget.node.children,
        onItemChanged: (int index, ConfigNode updatedNode) {
          _updateItem(index, updatedNode);
        },
        onRemove: _removeItem,
      );
    }

    if (_isPrimitiveArray) {
      return PrimitiveArrayDisplay(
        items: widget.node.children,
        onRemove: _removeItem,
      );
    }

    // Fallback for mixed/complex arrays
    return ObjectArrayDisplay(
      items: widget.node.children,
      onItemChanged: (int index, ConfigNode updatedNode) {
        _updateItem(index, updatedNode);
      },
      onRemove: _removeItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.space200),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.space300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header with type badge
            _ArrayHeader(
              title: widget.node.key ?? 'Array',
              itemCount: widget.node.children.length,
              arrayType: _arrayType,
            ),
            const SizedBox(height: DesignTokens.space200),

            // Input widget (context-aware)
            _buildInputWidget(),
            const SizedBox(height: DesignTokens.space200),

            // Display widget (context-aware)
            _buildDisplayWidget(),
          ],
        ),
      ),
    );
  }
}

/// Header widget for array with type badge.
class _ArrayHeader extends StatelessWidget {
  const _ArrayHeader({
    required this.title,
    required this.itemCount,
    required this.arrayType,
  });

  final String title;
  final int itemCount;
  final ArrayType arrayType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.list, color: DesignTokens.primaryColor, size: 20),
        const SizedBox(width: DesignTokens.space100),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        // Type badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.space100,
            vertical: DesignTokens.space50,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.surfaceVariantColor,
            borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
          ),
          child: Text(
            ArrayTypeDetector.getArrayTypeDescription(arrayType),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: DesignTokens.onSurfaceVariantColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.space100),
        // Count badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.space100,
            vertical: DesignTokens.space50,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.primaryColor,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          ),
          child: Text(
            '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
