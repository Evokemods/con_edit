import 'package:flutter/material.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../../features/metadata_management/presentation/widgets/validation_error_widget.dart';
import '../../../domain/entities/config_node.dart';

/// Widget for rendering multi-line text fields.
class MultilineTextWidget extends StatefulWidget {
  /// Creates a new MultilineTextWidget.
  const MultilineTextWidget({
    required this.node,
    required this.onChanged,
    this.maxLines = 5,
    this.minLines = 3,
    this.validationErrors = const <String>[],
    super.key,
  });

  /// The config node to render.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<ConfigNode> onChanged;

  /// Maximum number of lines to show.
  final int maxLines;

  /// Minimum number of lines to show.
  final int minLines;

  /// Validation errors to display.
  final List<String> validationErrors;

  @override
  State<MultilineTextWidget> createState() => _MultilineTextWidgetState();
}

class _MultilineTextWidgetState extends State<MultilineTextWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.node.value?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MultilineTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node.value != widget.node.value) {
      _controller.text = widget.node.value?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasErrors = widget.validationErrors.isNotEmpty;

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.node.key != null) ...<Widget>[
            Text(
              widget.node.key!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: DesignTokens.space100),
          ],
          TextField(
            controller: _controller,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Enter ${widget.node.key ?? "text"}',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: DesignTokens.onSurfaceVariantColor,
                  ),
              errorText: hasErrors ? '' : null,
              errorStyle: const TextStyle(height: 0),
            ),
            onChanged: (String value) {
              widget.onChanged(widget.node.copyWith(value: value));
            },
          ),
          if (hasErrors) ValidationErrorWidget(errors: widget.validationErrors),
        ],
      ),
    );
  }
}
