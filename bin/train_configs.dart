import 'dart:convert';
import 'dart:io';

import 'package:con_edit/core/database/app_database.dart';
import 'package:con_edit/core/error/failures.dart';
import 'package:con_edit/core/utils/logger.dart';
import 'package:con_edit/features/config_editor/data/repositories/config_repository_impl.dart';
import 'package:con_edit/features/config_editor/domain/entities/config_node.dart';
import 'package:con_edit/features/config_editor/domain/usecases/parse_json.dart';
import 'package:con_edit/features/file_management/data/repositories/file_repository_impl.dart';
import 'package:con_edit/features/metadata_management/data/datasources/metadata_dao.dart';
import 'package:con_edit/features/metadata_management/data/repositories/metadata_repository_impl.dart';
import 'package:con_edit/features/metadata_management/domain/entities/field_metadata.dart';
import 'package:con_edit/features/metadata_management/domain/usecases/extract_config_metadata.dart';
import 'package:con_edit/features/pattern_recognition/data/datasources/pattern_dao.dart';
import 'package:con_edit/features/pattern_recognition/data/repositories/pattern_repository_impl.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as path;

/// Script to train the system on all config files.
///
/// Analyzes all JSON config files in the config directory and extracts
/// metadata, patterns, and plugin-specific information.
Future<void> main(List<String> args) async {
  Logger.info('Starting config training...', name: 'TrainConfigs');

  // Get config directory path
  final String configDir = args.isNotEmpty
      ? args[0]
      : path.join(Directory.current.path, 'config');

  final Directory configDirectory = Directory(configDir);
  // ignore: avoid_slow_async_io
  if (!await configDirectory.exists()) {
    Logger.error(
      'Config directory does not exist: $configDir',
      name: 'TrainConfigs',
    );
    exit(1);
  }

  Logger.info('Training on config directory: $configDir', name: 'TrainConfigs');

  // Initialize database
  final AppDatabase database = AppDatabase();

  // Initialize repositories
  const ConfigRepositoryImpl configRepository = ConfigRepositoryImpl();
  const FileRepositoryImpl fileRepository = FileRepositoryImpl();
  final MetadataDao metadataDao = MetadataDao(database);
  final PatternDao patternDao = PatternDao(database);
  final PatternRepositoryImpl patternRepository = PatternRepositoryImpl(
    patternDao,
    metadataDao,
  );
  final MetadataRepositoryImpl metadataRepository = MetadataRepositoryImpl(
    fileRepository,
    metadataDao,
    patternRepository: patternRepository,
  );

  // Initialize use cases
  const ParseJson parseJson = ParseJson(configRepository);
  final ExtractConfigMetadata extractMetadata = ExtractConfigMetadata();

  // Run training manually
  Logger.info('Starting training process...', name: 'TrainConfigs');

  final List<String> processedPlugins = <String>[];
  int totalFields = 0;
  int totalMetadata = 0;

  final List<FileSystemEntity> files = configDirectory.listSync();
  for (final FileSystemEntity entity in files) {
    if (entity is File && entity.path.endsWith('.json')) {
      final String fileName = entity.path.split(Platform.pathSeparator).last;
      final String pluginName = fileName.replaceAll('.json', '');

      Logger.info('Training on: $fileName', name: 'TrainConfigs');

      try {
        final String content = await entity.readAsString();
        final Map<String, dynamic> config =
            jsonDecode(content) as Map<String, dynamic>;

        // Parse config
        final Either<Failure, ConfigNode> parseResult = await parseJson(
          jsonEncode(config),
        );

        await parseResult.fold(
          (Failure failure) async {
            Logger.error(
              'Failed to parse $fileName',
              error: failure.message,
              name: 'TrainConfigs',
            );
          },
          (ConfigNode rootNode) async {
            // Extract metadata
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
                  name: 'TrainConfigs',
                );
              },
              (List<FieldMetadata> metadataList) async {
                // Store metadata
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
                      name: 'TrainConfigs',
                    );
                  },
                  (void _) {
                    totalMetadata += metadataList.length;
                    totalFields += metadataList.length;
                    processedPlugins.add(pluginName);
                    Logger.info(
                      '✓ $pluginName: ${metadataList.length} fields',
                      name: 'TrainConfigs',
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
          name: 'TrainConfigs',
        );
      } on Object catch (e, stackTrace) {
        Logger.error(
          'Error training on $fileName',
          error: e,
          stackTrace: stackTrace,
          name: 'TrainConfigs',
        );
      }
    }
  }

  // Display results
  {
    final _TrainingResult trainingResult = _TrainingResult(
      processedPlugins: processedPlugins,
      totalFields: totalFields,
      totalMetadata: totalMetadata,
    );
    Logger.info(
      '\n'
      '╔═══════════════════════════════════════════════════════════╗\n'
      '║           CONFIG TRAINING COMPLETE                        ║\n'
      '╠═══════════════════════════════════════════════════════════╣\n'
      '║  Plugins Processed: ${trainingResult.processedPlugins.length.toString().padLeft(42)} ║\n'
      '║  Total Fields: ${trainingResult.totalFields.toString().padLeft(48)} ║\n'
      '║  Metadata Entries: ${trainingResult.totalMetadata.toString().padLeft(44)} ║\n'
      '╠═══════════════════════════════════════════════════════════╣\n'
      '║  Plugins:                                                ║',
      name: 'TrainConfigs',
    );

    for (final String plugin in trainingResult.processedPlugins) {
      Logger.info(
        '║    • $plugin${' ' * (55 - plugin.length)}║',
        name: 'TrainConfigs',
      );
    }

    Logger.info(
      '╚═══════════════════════════════════════════════════════════╝\n'
      'Training complete! The system has learned from all config files.\n'
      'You can now use the editor with enhanced field help and metadata.',
      name: 'TrainConfigs',
    );
  }

  await database.close();
  exit(0);
}

/// Result of a training session.
class _TrainingResult {
  /// Creates a new TrainingResult.
  const _TrainingResult({
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
