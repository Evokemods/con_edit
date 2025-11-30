import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../../config_editor/domain/entities/config_node.dart';
import '../../../config_editor/domain/usecases/parse_json.dart';
import '../../domain/entities/field_metadata.dart';
import '../repositories/metadata_repository.dart';
import 'extract_config_metadata.dart';

/// System for training on config files to build comprehensive knowledge base.
///
/// Analyzes all config files in a directory and extracts patterns,
/// field metadata, and plugin-specific information.
class ConfigTrainingSystem {
  /// Creates a new ConfigTrainingSystem.
  const ConfigTrainingSystem({
    required this.parseJson,
    required this.extractMetadata,
    required this.metadataRepository,
  });

  /// JSON parser for config files.
  final ParseJson parseJson;

  /// Metadata extractor.
  final ExtractConfigMetadata extractMetadata;

  /// Metadata repository for storing learned patterns.
  final MetadataRepository metadataRepository;

  /// Trains on all config files in a directory.
  ///
  /// Analyzes each config file, extracts metadata, and stores it
  /// for use in the knowledge base.
  Future<Either<Failure, TrainingResult>> trainOnDirectory(
    String directoryPath,
  ) async {
    try {
      final Directory directory = Directory(directoryPath);
      // ignore: avoid_slow_async_io
      if (!await directory.exists()) {
        return Left<Failure, TrainingResult>(
          UnexpectedFailure('Directory does not exist: $directoryPath'),
        );
      }

      final List<FileSystemEntity> files = directory.listSync();
      final List<String> processedPlugins = <String>[];
      int totalFields = 0;
      int totalMetadata = 0;

      for (final FileSystemEntity entity in files) {
        if (entity is File && entity.path.endsWith('.json')) {
          final String fileName = entity.path.split(Platform.pathSeparator).last;
          final String pluginName = fileName.replaceAll('.json', '');

          Logger.info(
            'Training on config: $fileName',
            name: 'ConfigTrainingSystem',
          );

          try {
            final String content = await entity.readAsString();
            final Map<String, dynamic> config = jsonDecode(content) as Map<String, dynamic>;

            // Parse config to ConfigNode tree
            final Either<Failure, ConfigNode> parseResult = await parseJson(
              jsonEncode(config),
            );

            await parseResult.fold(
              (Failure failure) async {
                Logger.error(
                  'Failed to parse $fileName',
                  error: failure.message,
                  name: 'ConfigTrainingSystem',
                );
              },
              (ConfigNode rootNode) async {
                // Extract metadata for this plugin
                final Either<Failure, List<FieldMetadata>> metadataResult =
                    await extractMetadata.extractMetadata(
                  rootNode,
                  pluginName: pluginName,
                );

                await metadataResult.fold(
                  (Failure failure) async {
                    Logger.error(
                      'Failed to extract metadata from $fileName',
                      error: failure.message,
                      name: 'ConfigTrainingSystem',
                    );
                  },
                  (List<FieldMetadata> metadataList) async {
                    // Store metadata for this plugin
                    // Use a virtual file path based on plugin name for organization
                    final String virtualFilePath = 'plugins/$pluginName.json';
                    final Either<Failure, void> saveResult =
                        await metadataRepository.saveMetadata(
                      virtualFilePath,
                      metadataList,
                    );

                    saveResult.fold(
                      (Failure failure) {
                        Logger.error(
                          'Failed to save metadata for $pluginName',
                          error: failure.message,
                          name: 'ConfigTrainingSystem',
                        );
                      },
                      (void _) {
                        totalMetadata += metadataList.length;
                        totalFields += metadataList.length;
                        processedPlugins.add(pluginName);

                        Logger.info(
                          'Trained on $pluginName: ${metadataList.length} fields',
                          name: 'ConfigTrainingSystem',
                        );
                      },
                    );
                  },
                );
              },
            );
          } on FormatException catch (e) {
            Logger.error(
              'Invalid JSON in $fileName',
              error: e,
              name: 'ConfigTrainingSystem',
            );
          } on Object catch (e, stackTrace) {
            Logger.error(
              'Error training on $fileName',
              error: e,
              stackTrace: stackTrace,
              name: 'ConfigTrainingSystem',
            );
          }
        }
      }

      final TrainingResult result = TrainingResult(
        processedPlugins: processedPlugins,
        totalFields: totalFields,
        totalMetadata: totalMetadata,
      );

      Logger.info(
        'Training complete: ${processedPlugins.length} plugins, '
        '$totalFields fields, $totalMetadata metadata entries',
        name: 'ConfigTrainingSystem',
      );

      return Right<Failure, TrainingResult>(result);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error in training system',
        error: e,
        stackTrace: stackTrace,
        name: 'ConfigTrainingSystem',
      );
      return Left<Failure, TrainingResult>(
        UnexpectedFailure('Training failed: $e'),
      );
    }
  }
}

/// Result of a training session.
class TrainingResult {
  /// Creates a new TrainingResult.
  const TrainingResult({
    required this.processedPlugins,
    required this.totalFields,
    required this.totalMetadata,
  });

  /// List of plugin names that were processed.
  final List<String> processedPlugins;

  /// Total number of fields analyzed.
  final int totalFields;

  /// Total number of metadata entries created.
  final int totalMetadata;
}

