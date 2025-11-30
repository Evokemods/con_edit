import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../config_editor/domain/entities/config_value_type.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/entities/metadata_constraint.dart';
import '../../domain/entities/widget_hint.dart';

/// Mapper for converting between FieldMetadata entity and database rows.
class FieldMetadataMapper {
  /// Converts a database row to a FieldMetadata entity.
  static FieldMetadata fromRow(
    FieldMetadataRow row,
    List<MetadataConstraintRow> constraints,
  ) {
    return FieldMetadata(
      fieldPath: row.fieldPath,
      description: row.description,
      tooltip: row.tooltip,
      valueType: row.valueType != null
          ? ConfigValueType.values.firstWhere(
              (ConfigValueType t) => t.name == row.valueType,
              orElse: () => ConfigValueType.string,
            )
          : null,
      constraints: constraints.map(_constraintFromRow).toList(),
      widgetHint: row.widgetHint != null
          ? WidgetHint(
              type: WidgetType.values.firstWhere(
                (WidgetType t) => t.name == row.widgetHint,
                orElse: () => WidgetType.textField,
              ),
            )
          : null,
      allowedValues: row.allowedValues != null
          ? (jsonDecode(row.allowedValues!) as List<dynamic>)
          : null,
      defaultValue:
          row.defaultValue != null ? jsonDecode(row.defaultValue!) : null,
      autocompleteSource: row.autocompleteSource,
      imagePreviewUrl: row.imagePreviewUrl,
      conditionalField: row.conditionalField,
      presetName: row.presetName,
      confidence: row.confidence,
      version: row.version,
    );
  }

  /// Converts a FieldMetadata entity to a database companion.
  static FieldMetadataTableCompanion toCompanion(
    FieldMetadata metadata, {
    String? pluginName,
    String? configType,
  }) {
    return FieldMetadataTableCompanion.insert(
      fieldPath: metadata.fieldPath,
      pluginName: Value<String?>(pluginName),
      configType: Value<String?>(configType),
      description: Value<String?>(metadata.description),
      tooltip: Value<String?>(metadata.tooltip),
      valueType: Value<String?>(metadata.valueType?.name),
      widgetHint: Value<String?>(metadata.widgetHint?.type.name),
      allowedValues: Value<String?>(
        metadata.allowedValues != null
            ? jsonEncode(metadata.allowedValues)
            : null,
      ),
      defaultValue: Value<String?>(
        metadata.defaultValue != null ? jsonEncode(metadata.defaultValue) : null,
      ),
      autocompleteSource: Value<String?>(metadata.autocompleteSource),
      imagePreviewUrl: Value<String?>(metadata.imagePreviewUrl),
      conditionalField: Value<String?>(metadata.conditionalField),
      presetName: Value<String?>(metadata.presetName),
      confidence: Value<double>(metadata.confidence),
      version: Value<String>(metadata.version),
    );
  }

  /// Converts a MetadataConstraint to a database companion.
  static MetadataConstraintsTableCompanion constraintToCompanion(
    int fieldMetadataId,
    MetadataConstraint constraint,
  ) {
    final Map<String, dynamic> constraintData = <String, dynamic>{
      'minValue': constraint.minValue,
      'maxValue': constraint.maxValue,
      'minLength': constraint.minLength,
      'maxLength': constraint.maxLength,
      'pattern': constraint.pattern,
    };

    return MetadataConstraintsTableCompanion.insert(
      fieldMetadataId: fieldMetadataId,
      constraintType: constraint.type.name,
      value: jsonEncode(constraintData),
      errorMessage: Value<String?>(constraint.customMessage),
    );
  }

  /// Converts a constraint row to a MetadataConstraint entity.
  static MetadataConstraint _constraintFromRow(MetadataConstraintRow row) {
    final Map<String, dynamic> data =
        jsonDecode(row.value) as Map<String, dynamic>;

    final ConstraintType type = ConstraintType.values.firstWhere(
      (ConstraintType t) => t.name == row.constraintType,
      orElse: () => ConstraintType.custom,
    );

    return MetadataConstraint(
      type: type,
      minValue: data['minValue'] as num?,
      maxValue: data['maxValue'] as num?,
      minLength: data['minLength'] as int?,
      maxLength: data['maxLength'] as int?,
      pattern: data['pattern'] as String?,
      customMessage: row.errorMessage,
    );
  }
}
