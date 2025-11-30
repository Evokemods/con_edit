import 'package:flutter/material.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../../core/widgets/hover_card.dart';
import '../../../../../features/metadata_management/presentation/widgets/validation_error_widget.dart';
import '../../../domain/entities/config_node.dart';

/// Widget for rendering dropdown/enum fields.
class DropdownWidget extends StatelessWidget {
  /// Creates a new DropdownWidget.
  const DropdownWidget({
    required this.node,
    required this.allowedValues,
    required this.onChanged,
    this.validationErrors = const <String>[],
    super.key,
  });

  /// The config node to render.
  final ConfigNode node;

  /// Allowed values for the dropdown.
  final List<dynamic> allowedValues;

  /// Callback when value changes.
  final ValueChanged<ConfigNode> onChanged;

  /// Validation errors to display.
  final List<String> validationErrors;

  @override
  Widget build(BuildContext context) {
    final dynamic currentValue = node.value;
    final String? selectedValue = currentValue?.toString();
    final bool hasErrors = validationErrors.isNotEmpty;

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (node.key != null) ...<Widget>[
            Text(
              node.key!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: DesignTokens.space100),
          ],
          DropdownButtonFormField<String>(
            initialValue: selectedValue != null &&
                    allowedValues
                        .map((dynamic v) => v.toString())
                        .contains(selectedValue)
                ? selectedValue
                : null,
            decoration: InputDecoration(
              hintText: 'Select ${node.key ?? "value"}',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: DesignTokens.onSurfaceVariantColor,
                  ),
              errorText: hasErrors ? '' : null,
              errorStyle: const TextStyle(height: 0),
            ),
            items: allowedValues.map((dynamic value) {
              final String stringValue = value.toString();
              return DropdownMenuItem<String>(
                value: stringValue,
                child: Text(stringValue),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                // Try to convert back to original type if it was numeric
                dynamic typedValue = newValue;
                if (currentValue is num) {
                  typedValue = num.tryParse(newValue) ?? newValue;
                } else if (currentValue is int) {
                  typedValue = int.tryParse(newValue) ?? newValue;
                } else if (currentValue is double) {
                  typedValue = double.tryParse(newValue) ?? newValue;
                }

                onChanged(node.copyWith(value: typedValue));
              }
            },
          ),
          if (hasErrors) ValidationErrorWidget(errors: validationErrors),
        ],
      ),
    );
  }
}
