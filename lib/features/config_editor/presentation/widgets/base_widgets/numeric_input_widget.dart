import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../domain/entities/config_node.dart';
import '../../../domain/entities/config_value_type.dart';
import '../field_label_with_help.dart';

/// Widget for editing numeric values.
class NumericInputWidget extends ConsumerStatefulWidget {
  /// Creates a new NumericInputWidget.
  const NumericInputWidget({
    required this.node,
    required this.onChanged,
    super.key,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<num> onChanged;

  @override
  ConsumerState<NumericInputWidget> createState() => _NumericInputWidgetState();
}

class _NumericInputWidgetState extends ConsumerState<NumericInputWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.node.value?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NumericInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node.value != widget.node.value) {
      _controller.text = widget.node.value?.toString() ?? '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInteger = widget.node.valueType == ConfigValueType.integer;

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
          Builder(
            builder: (BuildContext context) {
              // Get metadata to check if read-only
              final String fieldPath = widget.node.path.join('.');
              final FieldMetadata? metadata = ref.watch(
                fieldMetadataProvider(fieldPath),
              );
              final bool isReadOnly = metadata?.isReadOnly ?? false;

              return TextField(
                controller: _controller,
                enabled: !isReadOnly,
                readOnly: isReadOnly,
                keyboardType: isInteger
                    ? TextInputType.number
                    : const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  if (isInteger)
                    FilteringTextInputFormatter.digitsOnly
                  else
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isReadOnly
                          ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)
                          : null,
                    ),
                decoration: InputDecoration(
                  hintText: isReadOnly
                      ? 'Read-only (set by developer)'
                      : (isInteger ? 'Enter integer' : 'Enter number'),
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                  suffixIcon: isReadOnly
                      ? Tooltip(
                          message: 'This field is read-only and managed by the plugin',
                          child: Icon(
                            Icons.lock_outline,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        )
                      : null,
                ),
                onChanged: isReadOnly
                    ? null
                    : (String text) {
                        final num? parsed =
                            isInteger ? int.tryParse(text) : double.tryParse(text);
                        if (parsed != null) {
                          widget.onChanged(parsed);
                        }
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
