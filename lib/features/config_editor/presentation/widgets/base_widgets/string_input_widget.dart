import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../../core/widgets/image_preview_widget.dart';
import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/domain/entities/metadata_constraint.dart';
import '../../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../domain/entities/config_node.dart';
import '../field_label_with_help.dart';

/// Widget for editing string values.
class StringInputWidget extends ConsumerStatefulWidget {
  /// Creates a new StringInputWidget.
  const StringInputWidget({
    required this.node,
    required this.onChanged,
    super.key,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<String> onChanged;

  @override
  ConsumerState<StringInputWidget> createState() => _StringInputWidgetState();
}

class _StringInputWidgetState extends ConsumerState<StringInputWidget> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StringInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller if not currently focused (user isn't typing)
    if (!_focusNode.hasFocus && oldWidget.node.value != widget.node.value) {
      _controller.text = widget.node.value?.toString() ?? '';
    }
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
              final String currentText = _controller.text;

              if (currentText.isNotEmpty && metadata != null) {
                for (final MetadataConstraint constraint in metadata.constraints) {
                  if (constraint.type == ConstraintType.minLength) {
                    if (constraint.minLength != null && currentText.length < constraint.minLength!) {
                      errorText = constraint.customMessage ??
                        'Must be at least ${constraint.minLength} characters';
                      isValid = false;
                      break;
                    }
                  }
                  if (constraint.type == ConstraintType.maxLength ||
                      constraint.type == ConstraintType.lengthRange) {
                    if (constraint.maxLength != null && currentText.length > constraint.maxLength!) {
                      errorText = constraint.customMessage ??
                        'Must be at most ${constraint.maxLength} characters';
                      isValid = false;
                      break;
                    }
                  }
                  if (constraint.type == ConstraintType.pattern) {
                    if (constraint.pattern != null) {
                      final RegExp regex = RegExp(constraint.pattern!);
                      if (!regex.hasMatch(currentText)) {
                        errorText = constraint.customMessage ??
                          'Invalid format';
                        isValid = false;
                        break;
                      }
                    }
                  }
                  if (constraint.type == ConstraintType.required) {
                    if (currentText.isEmpty) {
                      errorText = constraint.customMessage ?? 'This field is required';
                      isValid = false;
                      break;
                    }
                  }
                }
              }

              // Get max length for character counter
              int? maxLength;
              for (final MetadataConstraint constraint in metadata?.constraints ?? <MetadataConstraint>[]) {
                if (constraint.type == ConstraintType.maxLength ||
                    constraint.type == ConstraintType.lengthRange) {
                  maxLength = constraint.maxLength;
                  break;
                }
              }

              // Character counter text
              String? counterText;
              TextStyle? counterStyle;
              if (maxLength != null) {
                counterText = '${currentText.length}/$maxLength';
                // Warning color if approaching limit (>90%)
                if (currentText.length > maxLength * 0.9) {
                  counterStyle = TextStyle(
                    color: currentText.length > maxLength
                      ? DesignTokens.errorColor
                      : DesignTokens.warningColor,
                    fontSize: 11,
                  );
                } else {
                  counterStyle = const TextStyle(
                    color: DesignTokens.onSurfaceVariantColor,
                    fontSize: 11,
                  );
                }
              }

              return TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: !isReadOnly,
                readOnly: isReadOnly,
                maxLength: maxLength,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isReadOnly
                          ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)
                          : null,
                    ),
                decoration: InputDecoration(
                  hintText: isReadOnly
                      ? 'Read-only (set by developer)'
                      : 'Enter ${widget.node.key ?? "text"}',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                  errorText: errorText,
                  counterText: counterText,
                  counterStyle: counterStyle,
                  suffixIcon: isReadOnly
                      ? Tooltip(
                          message: 'This field is read-only and managed by the plugin',
                          child: Icon(
                            Icons.lock_outline,
                            size: 18,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        )
                      : currentText.isNotEmpty && errorText == null
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
                      widget.onChanged(text);
                      // Rebuild for validation feedback (safe now with focus check)
                      setState(() {});
                    },
              );
            },
          ),

          // Show image preview if URL is an image
          Builder(
            builder: (BuildContext context) {
              final String fieldPath = widget.node.path.join('.');
              final FieldMetadata? metadata = ref.watch(
                fieldMetadataProvider(fieldPath),
              );

              // Check if we have an image preview URL
              if (metadata?.imagePreviewUrl != null) {
                return ImagePreviewWidget(
                  imageUrl: metadata!.imagePreviewUrl!,
                );
              }

              // Or check if current value looks like an image URL
              final String currentValue = _controller.text;
              if (currentValue.isNotEmpty &&
                  currentValue.startsWith('http') &&
                  (currentValue.toLowerCase().endsWith('.png') ||
                      currentValue.toLowerCase().endsWith('.jpg') ||
                      currentValue.toLowerCase().endsWith('.jpeg') ||
                      currentValue.toLowerCase().endsWith('.gif') ||
                      currentValue.toLowerCase().endsWith('.webp'))) {
                return ImagePreviewWidget(imageUrl: currentValue);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
