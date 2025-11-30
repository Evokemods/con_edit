import 'dart:io';

import 'package:con_edit/core/database/app_database.dart';
import 'package:con_edit/core/utils/logger.dart';
import 'package:con_edit/features/pattern_recognition/data/datasources/pattern_dao.dart';
import 'package:con_edit/features/pattern_recognition/data/datasources/pattern_tables.dart';

/// Script to clear all pattern data from the database.
Future<void> main() async {
  Logger.info(
    'Clearing all pattern data from database...',
    name: 'ClearPatternsScript',
  );

  // Initialize Database
  final AppDatabase database = AppDatabase();

  // Create DAO
  final PatternDao patternDao = PatternDao(database);

  try {
    // Get all patterns
    final List<ConfigPatternRow> allPatterns = await patternDao
        .getAllPatterns();
    final int patternCount = allPatterns.length;

    // Delete all patterns
    for (final ConfigPatternRow pattern in allPatterns) {
      await patternDao.deletePattern(pattern.id);
    }

    // Also clear field statistics
    final List<FieldStatisticsRow> allStats = await patternDao
        .getMostFrequentFields(limit: 100000);
    for (final FieldStatisticsRow stat in allStats) {
      await (database.delete(
        database.fieldStatisticsTable,
      )..where((FieldStatisticsTable tbl) => tbl.id.equals(stat.id))).go();
    }

    Logger.info(
      'Cleared $patternCount patterns and ${allStats.length} field statistics from database.',
      name: 'ClearPatternsScript',
    );
  } on Object catch (e, stackTrace) {
    Logger.error(
      'Error clearing patterns',
      error: e,
      stackTrace: stackTrace,
      name: 'ClearPatternsScript',
    );
    exit(1);
  }
}
