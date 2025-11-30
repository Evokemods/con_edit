import 'dart:io';

import 'package:con_edit/core/database/app_database.dart';
import 'package:con_edit/core/error/failures.dart';
import 'package:con_edit/core/utils/logger.dart';
import 'package:con_edit/features/metadata_management/data/datasources/metadata_dao.dart';
import 'package:con_edit/features/pattern_recognition/data/datasources/pattern_dao.dart';
import 'package:con_edit/features/pattern_recognition/data/repositories/pattern_repository_impl.dart';
import 'package:con_edit/features/pattern_recognition/domain/usecases/analyze_configs.dart';
import 'package:fpdart/fpdart.dart';

/// Script to analyze all config files and save patterns to database.
Future<void> main(List<String> args) async {
  final String configDir = args.isNotEmpty ? args[0] : 'config';

  Logger.info(
    'Starting config analysis for directory: $configDir',
    name: 'AnalyzeConfigsScript',
  );

  // Initialize Database
  final AppDatabase database = AppDatabase();

  // Create DAOs
  final MetadataDao metadataDao = MetadataDao(database);
  final PatternDao patternDao = PatternDao(database);

  // Set up repository
  final PatternRepositoryImpl patternRepository = PatternRepositoryImpl(
    patternDao,
    metadataDao,
  );

  // Create use case
  final AnalyzeConfigs analyzeConfigs = AnalyzeConfigs(patternRepository);

  // Analyze directory
  final Either<Failure, int> result = await analyzeConfigs.analyzeDirectory(
    configDir,
  );

  result.fold(
    (Failure failure) {
      Logger.error(
        'Analysis failed',
        error: failure.message,
        name: 'AnalyzeConfigsScript',
      );
      exit(1);
    },
    (int totalPatterns) {
      Logger.info(
        'Analysis complete! Total patterns saved: $totalPatterns',
        name: 'AnalyzeConfigsScript',
      );
      exit(0);
    },
  );
}
