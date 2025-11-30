import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';

/// Widget that wraps another widget with metadata tooltip and validation.
class MetadataTooltipWidget extends StatelessWidget {
  /// Creates a new MetadataTooltipWidget.
  const MetadataTooltipWidget({
    super.key,
    required this.child,
    this.metadata,
    this.error,
  });

  /// The child widget to wrap.
  final Widget child;

  /// Metadata for this field.
  final FieldMetadata? metadata;

  /// Validation error message.
  final String? error;

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    // Add tooltip if metadata has description
    if (metadata?.tooltip != null || metadata?.description != null) {
      result = Tooltip(
        message: metadata?.tooltip ?? metadata?.description ?? '',
        child: result,
      );
    }

    // Add error display if there's a validation error
    if (error != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          result,
          const SizedBox(height: AppDimensions.spacingXS),
          Row(
            children: <Widget>[
              Icon(
                Icons.error_outline,
                size: 16,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: AppDimensions.spacingXS),
              Expanded(
                child: Text(
                  error!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Add help icon if metadata has description
    if (metadata?.description != null && error == null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: result),
          Tooltip(
            message: metadata!.description!,
            child: Icon(
              Icons.help_outline,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    return result;
  }
}

