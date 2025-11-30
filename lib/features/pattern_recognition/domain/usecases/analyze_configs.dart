import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/config_pattern.dart';
import '../../domain/repositories/pattern_repository.dart';

/// Use case for analyzing multiple config files and saving patterns.
class AnalyzeConfigs {
  /// Creates a new AnalyzeConfigs use case.
  const AnalyzeConfigs(this.repository);

  /// Pattern repository.
  final PatternRepository repository;

  /// Analyzes all JSON config files in a directory and saves patterns.
  Future<Either<Failure, int>> analyzeDirectory(String directoryPath) async {
    try {
      final Directory directory = Directory(directoryPath);
      // ignore: avoid_slow_async_io
      if (!await directory.exists()) {
        return Left<Failure, int>(
          UnexpectedFailure('Directory does not exist: $directoryPath'),
        );
      }

      final List<FileSystemEntity> files = directory.listSync();
      int totalPatterns = 0;
      int processedFiles = 0;

      for (final FileSystemEntity entity in files) {
        if (entity is File && entity.path.endsWith('.json')) {
          final String fileName = entity.path.split(Platform.pathSeparator).last;
          final String pluginName = fileName.replaceAll('.json', '');

          Logger.info(
            'Analyzing config file: $fileName',
            name: 'AnalyzeConfigs',
          );

          try {
            final String content = await entity.readAsString();
            final Map<String, dynamic> config = jsonDecode(content) as Map<String, dynamic>;

            final Either<Failure, List<ConfigPattern>> result =
                await repository.analyzeConfig(
              config,
              pluginName: pluginName,
            );

            result.fold(
              (Failure failure) {
                Logger.error(
                  'Failed to analyze $fileName',
                  error: failure.message,
                  name: 'AnalyzeConfigs',
                );
              },
              (List<ConfigPattern> patterns) async {
                // Save each pattern
                for (final ConfigPattern pattern in patterns) {
                  final Either<Failure, void> saveResult =
                      await repository.savePattern(pattern);
                  saveResult.fold(
                    (Failure failure) {
                      Logger.error(
                        'Failed to save pattern for ${pattern.fieldName}',
                        error: failure.message,
                        name: 'AnalyzeConfigs',
                      );
                    },
                    (void _) {
                      totalPatterns++;
                    },
                  );
                }
                processedFiles++;
                Logger.info(
                  'Processed $fileName: ${patterns.length} patterns found',
                  name: 'AnalyzeConfigs',
                );
              },
            );
          } on FormatException catch (e) {
            Logger.error(
              'Invalid JSON in $fileName',
              error: e,
              name: 'AnalyzeConfigs',
            );
          } on Object catch (e, stackTrace) {
            Logger.error(
              'Error processing $fileName',
              error: e,
              stackTrace: stackTrace,
              name: 'AnalyzeConfigs',
            );
          }
        }
      }

      Logger.info(
        'Analysis complete: $processedFiles files processed, $totalPatterns patterns saved',
        name: 'AnalyzeConfigs',
      );

      return Right<Failure, int>(totalPatterns);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error analyzing directory',
        error: e,
        stackTrace: stackTrace,
        name: 'AnalyzeConfigs',
      );
      return Left<Failure, int>(
        UnexpectedFailure('Failed to analyze directory: $e'),
      );
    }
  }
}

