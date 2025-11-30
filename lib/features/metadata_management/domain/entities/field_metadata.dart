import 'package:equatable/equatable.dart';

import '../../../../features/config_editor/domain/entities/config_value_type.dart';
import 'metadata_constraint.dart';
import 'widget_hint.dart';

/// Metadata for a config field.
///
/// Provides hints, validation rules, and UI rendering information for fields.
class FieldMetadata extends Equatable {
  /// Creates new field metadata.
  const FieldMetadata({
    required this.fieldPath,
    this.description,
    this.tooltip,
    this.valueType,
    this.constraints = const <MetadataConstraint>[],
    this.widgetHint,
    this.allowedValues,
    this.defaultValue,
    this.autocompleteSource,
    this.imagePreviewUrl,
    this.conditionalField,
    this.presetName,
    this.confidence = 1.0,
    this.version = '1.0.0',
    this.isReadOnly = false,
  });

  /// The path to the field (e.g., "player.inventory.items[0].name").
  final String fieldPath;

  /// Human-readable description of the field.
  final String? description;

  /// Tooltip text shown on hover.
  final String? tooltip;

  /// Expected value type for this field.
  final ConfigValueType? valueType;

  /// Validation constraints for this field.
  final List<MetadataConstraint> constraints;

  /// Hint for which widget to use for rendering.
  final WidgetHint? widgetHint;

  /// Allowed values (for enums/dropdowns).
  final List<dynamic>? allowedValues;

  /// Default value suggestion.
  final dynamic defaultValue;

  /// Source for autocomplete suggestions.
  final String? autocompleteSource;

  /// URL for image preview (for item IDs, prefabs, etc.).
  final String? imagePreviewUrl;

  /// Field that this field depends on (for conditional rendering).
  final String? conditionalField;

  /// Preset/template name this field belongs to.
  final String? presetName;

  /// Confidence score (0.0 to 1.0) for learned metadata.
  final double confidence;

  /// Version of the metadata schema.
  final String version;

  /// Whether this field is read-only (should not be edited by users).
  final bool isReadOnly;

  /// Returns true if this metadata has high confidence.
  bool get isHighConfidence => confidence >= 0.7;

  /// Returns true if this metadata was learned (confidence < 1.0).
  bool get isLearned => confidence < 1.0;

  /// Creates a copy with updated fields.
  FieldMetadata copyWith({
    String? fieldPath,
    String? description,
    String? tooltip,
    ConfigValueType? valueType,
    List<MetadataConstraint>? constraints,
    WidgetHint? widgetHint,
    List<dynamic>? allowedValues,
    dynamic defaultValue,
    String? autocompleteSource,
    String? imagePreviewUrl,
    String? conditionalField,
    String? presetName,
    double? confidence,
    String? version,
    bool? isReadOnly,
  }) {
    return FieldMetadata(
      fieldPath: fieldPath ?? this.fieldPath,
      description: description ?? this.description,
      tooltip: tooltip ?? this.tooltip,
      valueType: valueType ?? this.valueType,
      constraints: constraints ?? this.constraints,
      widgetHint: widgetHint ?? this.widgetHint,
      allowedValues: allowedValues ?? this.allowedValues,
      defaultValue: defaultValue ?? this.defaultValue,
      autocompleteSource: autocompleteSource ?? this.autocompleteSource,
      imagePreviewUrl: imagePreviewUrl ?? this.imagePreviewUrl,
      conditionalField: conditionalField ?? this.conditionalField,
      presetName: presetName ?? this.presetName,
      confidence: confidence ?? this.confidence,
      version: version ?? this.version,
      isReadOnly: isReadOnly ?? this.isReadOnly,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        fieldPath,
        description,
        tooltip,
        valueType,
        constraints,
        widgetHint,
        allowedValues,
        defaultValue,
        autocompleteSource,
        imagePreviewUrl,
        conditionalField,
        presetName,
        confidence,
        version,
        isReadOnly,
      ];
}
