import 'package:flutter/material.dart';

import '../../../../metadata_management/domain/entities/widget_hint.dart';
import '../../../domain/entities/config_node.dart';
import 'config_node_widget.dart';

/// Widget for editing object values.
class ObjectWidget extends StatelessWidget {
  /// Creates a new ObjectWidget.
  const ObjectWidget({
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
  Widget build(BuildContext context) {
    final bool isCollapsible =
        widgetHint?.type == WidgetType.collapsibleSection;
    final String title = node.key ?? 'Object';

    if (isCollapsible) {
      return ExpansionTile(
        title: Text(title),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildChildren(context),
            ),
          ),
        ],
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (node.key != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ..._buildChildren(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return node.children.map((ConfigNode child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
          child: ConfigNodeWidget(
            node: child,
            onNodeChanged: (ConfigNode updatedNode) {
              final List<ConfigNode> newChildren = node.children.map((ConfigNode c) {
                final String? cKey = c.key;
                final String? updatedKey = updatedNode.key;
              if (cKey != null && updatedKey != null && cKey == updatedKey) {
                return updatedNode;
              }
              return c;
            }).toList();
            onNodeChanged?.call(node.copyWith(children: newChildren));
          },
        ),
      );
    }).toList();
  }
}

