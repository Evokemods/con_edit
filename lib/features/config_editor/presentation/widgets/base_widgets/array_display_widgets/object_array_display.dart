import 'package:flutter/material.dart';

import '../../../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/config_node.dart';
import '../config_node_widget.dart';

/// Widget for displaying object array items as expandable cards.
class ObjectArrayDisplay extends StatelessWidget {
  /// Creates a new ObjectArrayDisplay.
  const ObjectArrayDisplay({
    required this.items,
    required this.onItemChanged,
    required this.onRemove,
    super.key,
  });

  /// List of config nodes (objects) to display.
  final List<ConfigNode> items;

  /// Callback when an item is updated. Takes index and updated node.
  final void Function(int index, ConfigNode updatedNode) onItemChanged;

  /// Callback when an item should be removed.
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyArrayMessage();
    }

    return Column(
      children: items.asMap().entries.map((MapEntry<int, ConfigNode> entry) {
        final int index = entry.key;
        final ConfigNode child = entry.value;
        return _ObjectArrayItem(
          index: index,
          node: child,
          onChanged: (ConfigNode updatedNode) {
            onItemChanged(index, updatedNode);
          },
          onDeleted: () => onRemove(index),
        );
      }).toList(),
    );
  }
}

/// Widget for a single object in an array.
class _ObjectArrayItem extends StatelessWidget {
  const _ObjectArrayItem({
    required this.index,
    required this.node,
    required this.onChanged,
    required this.onDeleted,
  });

  final int index;
  final ConfigNode node;
  final ValueChanged<ConfigNode> onChanged;
  final VoidCallback onDeleted;

  /// Extracts a meaningful label from the object node.
  /// Looks for common identifier fields like id, name, shortname, etc.
  String _getItemLabel(ConfigNode node) {
    // Priority order for identifier fields
    final List<String> identifierFields = <String>[
      'id',
      'name',
      'shortname',
      'displayName',
      'title',
      'key',
      'identifier',
      'label',
      'type',
    ];

    // Search through children to find identifier fields
    for (final String fieldName in identifierFields) {
      final ConfigNode? child = node.children.cast<ConfigNode?>().firstWhere(
            (ConfigNode? child) =>
                child?.key?.toLowerCase() == fieldName.toLowerCase(),
            orElse: () => null,
          );
      if (child != null && child.value != null) {
        final String value = child.value.toString();
        if (value.isNotEmpty) {
          return value;
        }
      }
    }

    // Fallback to index if no identifier found
    return 'Item ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final String itemLabel = _getItemLabel(node);
    
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.space100),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.space100,
            vertical: DesignTokens.space50,
          ),
          decoration: BoxDecoration(
            color: DesignTokens.primaryColor,
            borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
          ),
          child: Text(
            '${index + 1}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        title: Text(
          itemLabel,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
          onPressed: onDeleted,
          tooltip: 'Remove item',
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(DesignTokens.space200),
            child: ConfigNodeWidget(
              node: node,
              onNodeChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state message for object arrays.
class _EmptyArrayMessage extends StatelessWidget {
  const _EmptyArrayMessage();

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
              'No objects added yet. Use the button above to add objects.',
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

