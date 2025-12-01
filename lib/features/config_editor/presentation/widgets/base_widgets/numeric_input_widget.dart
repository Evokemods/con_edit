import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/domain/entities/metadata_constraint.dart';
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
  final FocusNode _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NumericInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller if not currently focused (user isn't typing)
    if (!_focusNode.hasFocus && oldWidget.node.value != widget.node.value) {
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
              // Get metadata to check if read-only and constraints
              final String fieldPath = widget.node.path.join('.');
              final FieldMetadata? metadata = ref.watch(
                fieldMetadataProvider(fieldPath),
              );
              final bool isReadOnly = metadata?.isReadOnly ?? false;

              // Real-time validation
              String? errorText;
              bool isValid = true;
              final num? currentValue = isInteger
                ? int.tryParse(_controller.text)
                : double.tryParse(_controller.text);

              if (_controller.text.isNotEmpty && currentValue != null && metadata != null) {
                for (final MetadataConstraint constraint in metadata.constraints) {
                  if (constraint.type == ConstraintType.minValue ||
                      constraint.type == ConstraintType.range) {
                    if (constraint.minValue != null && currentValue < constraint.minValue!) {
                      errorText = constraint.customMessage ??
                        'Must be at least ${constraint.minValue}';
                      isValid = false;
                      break;
                    }
                  }
                  if (constraint.type == ConstraintType.maxValue ||
                      constraint.type == ConstraintType.range) {
                    if (constraint.maxValue != null && currentValue > constraint.maxValue!) {
                      errorText = constraint.customMessage ??
                        'Must be at most ${constraint.maxValue}';
                      isValid = false;
                      break;
                    }
                  }
                }
              }

              // Get range for helper text
              String? helperText;
              num? minValue;
              num? maxValue;
              for (final MetadataConstraint constraint in metadata?.constraints ?? <MetadataConstraint>[]) {
                if (constraint.type == ConstraintType.minValue ||
                    constraint.type == ConstraintType.range) {
                  minValue = constraint.minValue;
                }
                if (constraint.type == ConstraintType.maxValue ||
                    constraint.type == ConstraintType.range) {
                  maxValue = constraint.maxValue;
                }
              }
              if (minValue != null || maxValue != null) {
                helperText = 'Valid range: ${minValue ?? '-∞'} to ${maxValue ?? '∞'}';
              }

              return Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: !isReadOnly,
                      readOnly: isReadOnly,
                      keyboardType: isInteger
                          ? TextInputType.number
                          : const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        if (isInteger)
                          FilteringTextInputFormatter.digitsOnly
                        else
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
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
                        errorText: errorText,
                        helperText: helperText,
                        helperStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: DesignTokens.onSurfaceVariantColor,
                              fontSize: 11,
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
                            : _controller.text.isNotEmpty
                                ? Icon(
                                    isValid ? Icons.check_circle : Icons.error,
                                    color: isValid
                                      ? DesignTokens.successColor
                                      : DesignTokens.errorColor,
                                    size: 20,
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
                              // Rebuild for validation feedback (safe now with focus check)
                              setState(() {});
                            },
                    ),
                  ),
                  // Increment/Decrement buttons
                  if (!isReadOnly) ...<Widget>[
                    const SizedBox(width: DesignTokens.space100),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Increment button
                        SizedBox(
                          width: 32,
                          height: 24,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.arrow_drop_up, size: 20),
                            tooltip: 'Increment',
                            onPressed: () {
                              final num current = isInteger
                                  ? (int.tryParse(_controller.text) ?? 0)
                                  : (double.tryParse(_controller.text) ?? 0.0);
                              final num step = isInteger ? 1 : 0.1;
                              final num newValue = isInteger
                                  ? (current + step).toInt()
                                  : (current + step);
                              _controller.text = newValue.toString();
                              widget.onChanged(newValue);
                              setState(() {});
                            },
                          ),
                        ),
                        // Decrement button
                        SizedBox(
                          width: 32,
                          height: 24,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.arrow_drop_down, size: 20),
                            tooltip: 'Decrement',
                            onPressed: () {
                              final num current = isInteger
                                  ? (int.tryParse(_controller.text) ?? 0)
                                  : (double.tryParse(_controller.text) ?? 0.0);
                              final num step = isInteger ? 1 : 0.1;
                              final num newValue = isInteger
                                  ? (current - step).toInt()
                                  : (current - step);
                              _controller.text = newValue.toString();
                              widget.onChanged(newValue);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
