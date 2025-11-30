import 'package:flutter/material.dart';

import '../../../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/config_node.dart';
import '../../../../domain/entities/config_value_type.dart';

/// Widget for displaying primitive array items as chips.
class PrimitiveArrayDisplay extends StatelessWidget {
  /// Creates a new PrimitiveArrayDisplay.
  const PrimitiveArrayDisplay({
    required this.items,
    required this.onRemove,
    super.key,
  });

  /// List of config nodes to display.
  final List<ConfigNode> items;

  /// Callback when an item should be removed.
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyArrayMessage();
    }

    return Wrap(
      spacing: DesignTokens.space100,
      runSpacing: DesignTokens.space100,
      children: items.asMap().entries.map((MapEntry<int, ConfigNode> entry) {
        final int index = entry.key;
        final ConfigNode child = entry.value;
        return _ArrayChip(
          value: child.value,
          valueType: child.valueType,
          index: index,
          onDeleted: () => onRemove(index),
        );
      }).toList(),
    );
  }
}

/// Chip widget for displaying a single array item.
class _ArrayChip extends StatelessWidget {
  const _ArrayChip({
    required this.value,
    required this.valueType,
    required this.index,
    required this.onDeleted,
  });

  final dynamic value;
  final ConfigValueType valueType;
  final int index;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    // Format value based on type
    String displayValue = value?.toString() ?? 'null';
    
    if (valueType == ConfigValueType.string && value is String) {
      displayValue = value as String;
    } else if (valueType == ConfigValueType.double && value is num) {
      // Format doubles nicely
      final double d = (value as num).toDouble();
      if (d == d.roundToDouble()) {
        displayValue = d.toInt().toString();
      } else {
        displayValue = d.toStringAsFixed(2);
      }
    }

    return Chip(
      label: Text(displayValue),
      backgroundColor: DesignTokens.primaryColor.withValues(alpha: 0.1),
      labelStyle: const TextStyle(
        color: DesignTokens.primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      deleteIcon: const Icon(
        Icons.close,
        size: 16,
        color: DesignTokens.primaryColor,
      ),
      onDeleted: onDeleted,
      avatar: _getTypeIcon(valueType),
    );
  }

  Widget? _getTypeIcon(ConfigValueType type) {
    switch (type) {
      case ConfigValueType.string:
        return const Icon(
          Icons.text_fields,
          size: 16,
          color: DesignTokens.primaryColor,
        );
      case ConfigValueType.integer:
      case ConfigValueType.double:
        return const Icon(
          Icons.numbers,
          size: 16,
          color: DesignTokens.primaryColor,
        );
      case ConfigValueType.boolean:
        return const Icon(
          Icons.check_circle,
          size: 16,
          color: DesignTokens.primaryColor,
        );
      default:
        return null;
    }
  }
}

/// Empty state message for arrays.
class _EmptyArrayMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.space200),
      decoration: BoxDecoration(
        color: DesignTokens.surfaceVariantColor,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
        border: Border.all(
          color: DesignTokens.dividerColor,
        ),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.info_outline,
            size: 16,
            color: DesignTokens.onSurfaceVariantColor,
          ),
          const SizedBox(width: DesignTokens.space100),
          Expanded(
            child: Text(
              'No items added yet. Use the input above to add items.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: DesignTokens.onSurfaceVariantColor,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

