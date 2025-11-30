import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../../metadata_management/presentation/services/widget_selector.dart';
import '../../../domain/entities/config_node.dart';

/// Main widget for rendering a ConfigNode based on its type and metadata.
///
/// This widget automatically selects the appropriate input widget based on:
/// 1. Metadata hints (if available)
/// 2. Node value type
/// 3. Allowed values from metadata
class ConfigNodeWidget extends ConsumerWidget {
  /// Creates a new ConfigNodeWidget.
  const ConfigNodeWidget({
    required this.node,
    required this.onNodeChanged,
    super.key,
  });

  /// The config node to render.
  final ConfigNode node;

  /// Callback when node changes.
  final ValueChanged<ConfigNode> onNodeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Convert node path to dot-separated string for metadata lookup
    final String fieldPath = node.path.join('.');

    // Fetch metadata for this node's path (now using fast cache lookup)
    final FieldMetadata? metadata = ref.watch(
      fieldMetadataProvider(fieldPath),
    );

    return WidgetSelector.selectWidget(
      node: node,
      onChanged: onNodeChanged,
      metadata: metadata,
    );
  }
}
