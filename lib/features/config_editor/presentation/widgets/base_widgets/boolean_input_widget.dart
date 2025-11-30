import 'package:flutter/material.dart';

import '../../../../../core/widgets/hover_card.dart';
import '../../../domain/entities/config_node.dart';

/// Widget for editing boolean values.
class BooleanInputWidget extends StatelessWidget {
  /// Creates a new BooleanInputWidget.
  const BooleanInputWidget({
    required this.node,
    required this.onChanged,
    super.key,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool value = node.value as bool? ?? false;

    return HoverCard(
      child: Row(
        children: <Widget>[
          if (node.key != null)
            Expanded(
              child: Text(
                node.key!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
