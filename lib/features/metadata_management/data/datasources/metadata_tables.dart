import 'package:drift/drift.dart';

/// Table for storing field metadata.
///
/// Stores metadata information for config fields including descriptions,
/// constraints, widget hints, and confidence scores.
@DataClassName('FieldMetadataRow')
class FieldMetadataTable extends Table {
  @override
  String get tableName => 'field_metadata';

  /// Unique identifier for this metadata entry.
  IntColumn get id => integer().autoIncrement()();

  /// The path to the field (e.g., "player.inventory.items[0].name").
  TextColumn get fieldPath => text()();

  /// Optional plugin name this metadata is specific to.
  TextColumn get pluginName => text().nullable()();

  /// Optional config type (e.g., "skill", "loot_table").
  TextColumn get configType => text().nullable()();

  /// Human-readable description of the field.
  TextColumn get description => text().nullable()();

  /// Tooltip text shown on hover.
  TextColumn get tooltip => text().nullable()();

  /// Expected value type (stored as string enum).
  TextColumn get valueType => text().nullable()();

  /// Widget hint for rendering (stored as string enum).
  TextColumn get widgetHint => text().nullable()();

  /// Allowed values as JSON array (for enums/dropdowns).
  TextColumn get allowedValues => text().nullable()();

  /// Default value as JSON.
  TextColumn get defaultValue => text().nullable()();

  /// Autocomplete source identifier.
  TextColumn get autocompleteSource => text().nullable()();

  /// URL for image preview.
  TextColumn get imagePreviewUrl => text().nullable()();

  /// Field that this field depends on (for conditional rendering).
  TextColumn get conditionalField => text().nullable()();

  /// Preset/template name.
  TextColumn get presetName => text().nullable()();

  /// Confidence score (0.0 to 1.0) for learned metadata.
  RealColumn get confidence => real().withDefault(const Constant<double>(1.0))();

  /// Version of the metadata schema.
  TextColumn get version => text().withDefault(const Constant<String>('1.0.0'))();

  /// When this metadata was created.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// When this metadata was last updated.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// Table for storing metadata constraints.
///
/// Stores validation rules for fields (min/max values, patterns, etc.).
@DataClassName('MetadataConstraintRow')
class MetadataConstraintsTable extends Table {
  @override
  String get tableName => 'metadata_constraints';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to field_metadata table.
  IntColumn get fieldMetadataId => integer().references(
        FieldMetadataTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// Type of constraint (e.g., "min", "max", "pattern", "required").
  TextColumn get constraintType => text()();

  /// Value for the constraint as JSON.
  TextColumn get value => text()();

  /// Error message to show when constraint is violated.
  TextColumn get errorMessage => text().nullable()();
}
