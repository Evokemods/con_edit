import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';

/// Widget that displays a field label with optional help icon and tooltip.
class FieldLabelWithHelp extends StatelessWidget {
  /// Creates a new FieldLabelWithHelp.
  const FieldLabelWithHelp({
    required this.label,
    this.metadata,
    super.key,
  });

  /// The field label text.
  final String label;

  /// Optional metadata for help information.
  final FieldMetadata? metadata;

  @override
  Widget build(BuildContext context) {
    final bool hasHelp = metadata?.tooltip != null || metadata?.description != null;

    if (!hasHelp) {
      return Text(
        label,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(width: DesignTokens.space100),
        _HelpIcon(
          tooltip: metadata?.tooltip ?? metadata?.description ?? '',
          hasDocumentation: _hasDocumentationUrl(metadata),
        ),
      ],
    );
  }

  /// Checks if metadata contains documentation URLs.
  bool _hasDocumentationUrl(FieldMetadata? metadata) {
    final String? tooltip = metadata?.tooltip;
    if (tooltip != null) {
      final RegExp urlPattern = RegExp(
        r'https?://[^\s]+',
        caseSensitive: false,
      );
      return urlPattern.hasMatch(tooltip);
    }
    return false;
  }
}

/// Help icon with tooltip.
class _HelpIcon extends StatelessWidget {
  const _HelpIcon({
    required this.tooltip,
    this.hasDocumentation = false,
  });

  final String tooltip;
  final bool hasDocumentation;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.space50),
        child: Icon(
          hasDocumentation ? Icons.info_outline : Icons.help_outline,
          size: 18,
          color: hasDocumentation
              ? DesignTokens.primaryColor
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

