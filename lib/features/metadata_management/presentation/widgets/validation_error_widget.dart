import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';

/// Widget for displaying validation errors inline.
class ValidationErrorWidget extends StatelessWidget {
  /// Creates a new ValidationErrorWidget.
  const ValidationErrorWidget({
    required this.errors,
    super.key,
  });

  /// List of error messages to display.
  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    if (errors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingSmall,
        bottom: AppDimensions.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: errors.map((String error) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: AppDimensions.paddingXS,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: Text(
                    error,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
