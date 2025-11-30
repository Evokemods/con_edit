import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'pattern_tables.dart';

part 'pattern_dao.g.dart';

/// Data Access Object for pattern recognition operations.
///
/// Provides CRUD operations for patterns, feedback, and field statistics.
@DriftAccessor(
  tables: <Type>[ConfigPatternsTable, PatternFeedbackTable, FieldStatisticsTable],
)
class PatternDao extends DatabaseAccessor<AppDatabase> with _$PatternDaoMixin {
  /// Creates a new PatternDao.
  PatternDao(super.db);

  // ==================== ConfigPattern Operations ====================

  /// Gets all patterns.
  Future<List<ConfigPatternRow>> getAllPatterns() {
    return select(configPatternsTable).get();
  }

  /// Gets a pattern by ID.
  Future<ConfigPatternRow?> getPatternById(String id) {
    return (select(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Gets patterns by field name.
  Future<List<ConfigPatternRow>> getPatternsByField(String fieldName) {
    return (select(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.fieldName.equals(fieldName)))
        .get();
  }

  /// Gets patterns by plugin name.
  Future<List<ConfigPatternRow>> getPatternsByPlugin(String pluginName) {
    return (select(configPatternsTable)
          ..where(
            (ConfigPatternsTable tbl) => tbl.pluginName.equals(pluginName),
          ))
        .get();
  }

  /// Gets high-confidence patterns (confidence >= 0.7).
  Future<List<ConfigPatternRow>> getHighConfidencePatterns() {
    return (select(configPatternsTable)
          ..where(
            (ConfigPatternsTable tbl) =>
                tbl.confidence.isBiggerOrEqualValue(0.7),
          ))
        .get();
  }

  /// Gets patterns ordered by confidence (descending).
  Future<List<ConfigPatternRow>> getPatternsByConfidence() {
    return (select(configPatternsTable)
          ..orderBy(
            <OrderingTerm Function(ConfigPatternsTable)>[
              (ConfigPatternsTable t) => OrderingTerm.desc(t.confidence),
            ],
          ))
        .get();
  }

  /// Inserts a new pattern.
  Future<void> insertPattern(ConfigPatternsTableCompanion pattern) {
    return into(configPatternsTable).insert(pattern);
  }

  /// Inserts or updates a pattern (upsert).
  Future<void> upsertPattern(ConfigPatternsTableCompanion pattern) {
    return into(configPatternsTable).insertOnConflictUpdate(pattern);
  }

  /// Finds an existing pattern by field name, plugin, and metadata ID.
  Future<ConfigPatternRow?> findExistingPattern({
    required String fieldName,
    String? pluginName,
    String? configType,
    int? metadataId,
  }) {
    final SimpleSelectStatement<$ConfigPatternsTableTable, ConfigPatternRow>
        query = select(configPatternsTable)
      ..where(
        (ConfigPatternsTable tbl) => tbl.fieldName.equals(fieldName),
      );

    if (pluginName != null) {
      query.where(
        (ConfigPatternsTable tbl) => tbl.pluginName.equals(pluginName),
      );
    } else {
      query.where(
        (ConfigPatternsTable tbl) => tbl.pluginName.isNull(),
      );
    }

    if (configType != null) {
      query.where(
        (ConfigPatternsTable tbl) => tbl.configType.equals(configType),
      );
    } else {
      query.where(
        (ConfigPatternsTable tbl) => tbl.configType.isNull(),
      );
    }

    if (metadataId != null) {
      query.where(
        (ConfigPatternsTable tbl) => tbl.metadataId.equals(metadataId),
      );
    }

    return query.getSingleOrNull();
  }

  /// Updates a pattern.
  Future<int> updatePattern(String id, ConfigPatternsTableCompanion pattern) {
    return (update(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.id.equals(id)))
        .write(pattern);
  }

  /// Increments pattern occurrence count.
  Future<void> incrementPatternOccurrence(String id) async {
    final ConfigPatternRow? pattern = await getPatternById(id);
    if (pattern == null) return;

    await (update(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.id.equals(id)))
        .write(
      ConfigPatternsTableCompanion(
        occurrences: Value<int>(pattern.occurrences + 1),
        lastSeen: Value<DateTime>(DateTime.now()),
      ),
    );
  }

  /// Updates pattern confidence based on feedback.
  Future<void> updatePatternConfidence(String id, double newConfidence) {
    return (update(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.id.equals(id)))
        .write(
      ConfigPatternsTableCompanion(
        confidence: Value<double>(newConfidence),
      ),
    );
  }

  /// Deletes a pattern.
  Future<int> deletePattern(String id) {
    return (delete(configPatternsTable)
          ..where((ConfigPatternsTable tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Deletes all patterns.
  Future<int> deleteAllPatterns() {
    return delete(configPatternsTable).go();
  }

  /// Deletes all field statistics.
  Future<int> deleteAllFieldStatistics() {
    return delete(fieldStatisticsTable).go();
  }

  // ==================== PatternFeedback Operations ====================

  /// Records user feedback for a pattern.
  Future<int> recordFeedback(PatternFeedbackTableCompanion feedback) {
    return into(patternFeedbackTable).insert(feedback);
  }

  /// Gets all feedback for a pattern.
  Future<List<PatternFeedbackRow>> getPatternFeedback(String patternId) {
    return (select(patternFeedbackTable)
          ..where(
            (PatternFeedbackTable tbl) => tbl.patternId.equals(patternId),
          ))
        .get();
  }

  /// Gets acceptance rate for a pattern.
  Future<double> getPatternAcceptanceRate(String patternId) async {
    final List<PatternFeedbackRow> feedback =
        await getPatternFeedback(patternId);
    if (feedback.isEmpty) return 0.0;

    final int accepted =
        feedback.where((PatternFeedbackRow f) => f.accepted).length;
    return accepted / feedback.length;
  }

  // ==================== FieldStatistics Operations ====================

  /// Gets statistics for a field.
  Future<FieldStatisticsRow?> getFieldStatistics({
    required String fieldName,
    String? pluginName,
    String? configType,
  }) {
    final SimpleSelectStatement<$FieldStatisticsTableTable, FieldStatisticsRow>
        query = select(fieldStatisticsTable)
          ..where(
            (FieldStatisticsTable tbl) => tbl.fieldName.equals(fieldName),
          );

    if (pluginName != null) {
      query.where(
        (FieldStatisticsTable tbl) => tbl.pluginName.equals(pluginName),
      );
    }
    if (configType != null) {
      query.where(
        (FieldStatisticsTable tbl) => tbl.configType.equals(configType),
      );
    }

    return query.getSingleOrNull();
  }

  /// Inserts or updates field statistics.
  Future<int> upsertFieldStatistics(FieldStatisticsTableCompanion stats) {
    return into(fieldStatisticsTable).insertOnConflictUpdate(stats);
  }

  /// Increments field frequency.
  Future<void> incrementFieldFrequency({
    required String fieldName,
    String? pluginName,
    String? configType,
  }) async {
    final FieldStatisticsRow? stats = await getFieldStatistics(
      fieldName: fieldName,
      pluginName: pluginName,
      configType: configType,
    );

    if (stats == null) {
      // Create new statistics entry
      await upsertFieldStatistics(
        FieldStatisticsTableCompanion.insert(
          fieldName: fieldName,
          pluginName: Value<String?>(pluginName),
          configType: Value<String?>(configType),
          lastSeen: DateTime.now(),
        ),
      );
    } else {
      // Increment existing
      await (update(fieldStatisticsTable)
            ..where((FieldStatisticsTable tbl) => tbl.id.equals(stats.id)))
          .write(
        FieldStatisticsTableCompanion(
          frequency: Value<int>(stats.frequency + 1),
          lastSeen: Value<DateTime>(DateTime.now()),
        ),
      );
    }
  }

  /// Gets most frequent fields.
  Future<List<FieldStatisticsRow>> getMostFrequentFields({int limit = 50}) {
    return (select(fieldStatisticsTable)
          ..orderBy(
            <OrderingTerm Function(FieldStatisticsTable)>[
              (FieldStatisticsTable t) => OrderingTerm.desc(t.frequency),
            ],
          )
          ..limit(limit))
        .get();
  }

  /// Deletes old statistics (cleanup).
  Future<int> deleteOldStatistics(DateTime before) {
    return (delete(fieldStatisticsTable)
          ..where(
            (FieldStatisticsTable tbl) => tbl.lastSeen.isSmallerThan(
              Constant<DateTime>(before),
            ),
          ))
        .go();
  }
}
