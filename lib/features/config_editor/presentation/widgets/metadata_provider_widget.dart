import 'package:flutter/material.dart';

import '../../../metadata_management/domain/entities/field_metadata.dart';

/// InheritedWidget that provides metadata map to descendant widgets.
///
/// This allows nested ConfigNodeWidgets (in arrays/objects) to access
/// pre-computed metadata without additional provider watches.
class MetadataProvider extends InheritedWidget {
  /// Creates a new MetadataProvider.
  const MetadataProvider({
    required this.metadataMap,
    required super.child,
    super.key,
  });

  /// Map of field paths to metadata.
  final Map<String, FieldMetadata> metadataMap;

  /// Gets the metadata map from the nearest MetadataProvider ancestor.
  static Map<String, FieldMetadata>? of(BuildContext context) {
    final MetadataProvider? provider =
        context.dependOnInheritedWidgetOfExactType<MetadataProvider>();
    return provider?.metadataMap;
  }

  @override
  bool updateShouldNotify(MetadataProvider oldWidget) {
    return metadataMap != oldWidget.metadataMap;
  }
}
