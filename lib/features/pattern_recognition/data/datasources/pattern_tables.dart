import 'package:drift/drift.dart';

/// Table for storing recognized config patterns.
///
/// Stores learned patterns that can be applied to similar configs,
/// including confidence scores and usage statistics.
@DataClassName('ConfigPatternRow')
class ConfigPatternsTable extends Table {
  @override
  String get tableName => 'config_patterns';

  /// Unique identifier (UUID stored as text).
  TextColumn get id => text()();

  /// Name of the field this pattern applies to.
  TextColumn get fieldName => text()();

  /// Plugin name (if pattern is plugin-specific).
  TextColumn get pluginName => text().nullable()();

  /// Type of config (e.g., "skill", "loot_table", "npc").
  TextColumn get configType => text().nullable()();

  /// Confidence score (0.0 to 1.0).
  RealColumn get confidence => real()();

  /// Number of times this pattern was observed.
  IntColumn get occurrences => integer().withDefault(const Constant<int>(1))();

  /// Last time this pattern was observed.
  DateTimeColumn get lastSeen => dateTime()();

  /// When this pattern was first created.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// Foreign key to field_metadata (the inferred metadata).
  IntColumn get metadataId => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

/// Table for tracking pattern acceptance/rejection by users.
///
/// Stores feedback loop data to improve pattern recognition over time.
@DataClassName('PatternFeedbackRow')
class PatternFeedbackTable extends Table {
  @override
  String get tableName => 'pattern_feedback';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to config_patterns.
  TextColumn get patternId => text().references(
        ConfigPatternsTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// Whether the user accepted (true) or rejected (false) the pattern.
  BoolColumn get accepted => boolean()();

  /// Optional user modification to the pattern as JSON.
  TextColumn get userModification => text().nullable()();

  /// When the feedback was provided.
  DateTimeColumn get feedbackAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// Table for tracking field statistics across configs.
///
/// Used for pattern recognition to identify common fields and their properties.
@DataClassName('FieldStatisticsRow')
class FieldStatisticsTable extends Table {
  @override
  String get tableName => 'field_statistics';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Field name (without path).
  TextColumn get fieldName => text()();

  /// Optional plugin name.
  TextColumn get pluginName => text().nullable()();

  /// Optional config type.
  TextColumn get configType => text().nullable()();

  /// Most common value type observed.
  TextColumn get commonValueType => text().nullable()();

  /// Observed minimum value (for numeric fields) as JSON.
  TextColumn get minValue => text().nullable()();

  /// Observed maximum value (for numeric fields) as JSON.
  TextColumn get maxValue => text().nullable()();

  /// Observed enum values as JSON array.
  TextColumn get enumValues => text().nullable()();

  /// Number of times this field was encountered.
  IntColumn get frequency => integer().withDefault(const Constant<int>(1))();

  /// Last time this field was seen.
  DateTimeColumn get lastSeen => dateTime()();

  /// When this statistic was first created.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
