import 'package:flutter/material.dart';

import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/presentation/services/widget_selector.dart';
import '../../../domain/entities/config_node.dart';
import '../metadata_provider_widget.dart';

/// Main widget for rendering a ConfigNode based on its type and metadata.
///
/// This widget selects the appropriate input widget based on:
/// 1. Pre-computed metadata (if provided directly)
/// 2. Metadata from MetadataProvider (for nested widgets)
/// 3. Node value type
/// 4. Allowed values from metadata
///
/// **Performance Note:** Metadata should be pre-computed at the page level
/// to avoid N+1 provider watches. Pass the metadata directly instead of
/// looking it up per-widget.
class ConfigNodeWidget extends StatelessWidget {
  /// Creates a new ConfigNodeWidget.
  const ConfigNodeWidget({
    required this.node,
    required this.onNodeChanged,
    this.metadata,
    super.key,
  });

  /// The config node to render.
  final ConfigNode node;

  /// Callback when node changes.
  final ValueChanged<ConfigNode> onNodeChanged;

  /// Pre-computed metadata for this node (optional).
  /// When provided, avoids provider lookup for better performance.
  /// If not provided, will try to look up from MetadataProvider.
  final FieldMetadata? metadata;

  @override
  Widget build(BuildContext context) {
    // Try to get metadata from:
    // 1. Direct parameter (if provided)
    // 2. MetadataProvider (for nested widgets in arrays/objects)
    FieldMetadata? effectiveMetadata = metadata;
    if (effectiveMetadata == null) {
      final Map<String, FieldMetadata>? metadataMap = MetadataProvider.of(context);
      if (metadataMap != null) {
        final String fieldPath = node.path.join('.');
        effectiveMetadata = metadataMap[fieldPath];
      }
    }

    return WidgetSelector.selectWidget(
      node: node,
      onChanged: onNodeChanged,
      metadata: effectiveMetadata,
    );
  }
}
