import 'dart:convert';

import 'package:fpdart/fpdart.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../../file_management/domain/repositories/file_repository.dart';
import '../../../pattern_recognition/domain/entities/config_pattern.dart';
import '../../../pattern_recognition/domain/repositories/pattern_repository.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/entities/metadata_constraint.dart';
import '../../domain/repositories/metadata_repository.dart';
import '../datasources/metadata_dao.dart';
import '../models/field_metadata_mapper.dart';

/// Implementation of MetadataRepository.
///
/// Uses a hybrid approach: stores metadata in database for quick access
/// and can sync with external .metadata.json files.
/// Falls back to learned patterns when explicit metadata isn't available.
class MetadataRepositoryImpl implements MetadataRepository {
  /// Creates a new MetadataRepositoryImpl.
  const MetadataRepositoryImpl(
    this.fileRepository,
    this.metadataDao, {
    this.patternRepository,
  });

  /// File repository for reading/writing metadata files.
  final FileRepository fileRepository;

  /// Database DAO for metadata operations.
  final MetadataDao metadataDao;

  /// Pattern repository for learned patterns (optional).
  final PatternRepository? patternRepository;

  @override
  Future<Either<Failure, List<FieldMetadata>>> loadMetadata(
    String filePath,
  ) async {
    try {
      // Try to load from database first
      final List<FieldMetadataRow> dbMetadata = await metadataDao
          .getAllMetadata();

      // Convert database rows to entities
      final List<FieldMetadata> metadata = <FieldMetadata>[];
      for (final FieldMetadataRow row in dbMetadata) {
        final List<MetadataConstraintRow> constraints = await metadataDao
            .getConstraints(row.id);
        metadata.add(FieldMetadataMapper.fromRow(row, constraints));
      }

      // If database is empty, try loading from file and sync to database
      if (metadata.isEmpty) {
        final Either<Failure, List<FieldMetadata>> fileResult =
            await _loadFromFile(filePath);
        return fileResult.fold(
          (Failure failure) => Left<Failure, List<FieldMetadata>>(failure),
          (List<FieldMetadata> fileMetadata) async {
            // Save to database for future use
            for (final FieldMetadata meta in fileMetadata) {
              await _saveToDatabase(meta);
            }
            return Right<Failure, List<FieldMetadata>>(fileMetadata);
          },
        );
      }

      return Right<Failure, List<FieldMetadata>>(metadata);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Unexpected error loading metadata',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      return Left<Failure, List<FieldMetadata>>(
        UnexpectedFailure('Failed to load metadata: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveMetadata(
    String filePath,
    List<FieldMetadata> metadata,
  ) async {
    try {
      // Save to database
      for (final FieldMetadata meta in metadata) {
        await _saveToDatabase(meta);
      }

      // Also save to file for external use
      final String metadataPath = fileRepository.getMetadataPath(filePath);
      final Map<String, dynamic> json = <String, dynamic>{
        'version': '1.0.0',
        'metadata': metadata.map((FieldMetadata m) => _toJson(m)).toList(),
      };
      final String content = const JsonEncoder.withIndent('  ').convert(json);
      return await fileRepository.writeFile(metadataPath, content);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Unexpected error saving metadata',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      return Left<Failure, void>(
        UnexpectedFailure('Failed to save metadata: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, FieldMetadata?>> getFieldMetadata(
    String configFilePath,
    String fieldPath,
  ) async {
    try {
      // Try database first
      final FieldMetadataRow? row = await metadataDao.getMetadataByPath(
        fieldPath,
      );

      if (row != null) {
        final List<MetadataConstraintRow> constraints = await metadataDao
            .getConstraints(row.id);
        return Right<Failure, FieldMetadata?>(
          FieldMetadataMapper.fromRow(row, constraints),
        );
      }

      // Fall back to file if not in database
      final Either<Failure, List<FieldMetadata>> metadataResult =
          await loadMetadata(configFilePath);
      final Either<Failure, FieldMetadata?> fileMetadata = metadataResult.fold(
        (Failure failure) => Left<Failure, FieldMetadata?>(failure),
        (List<FieldMetadata> metadataList) {
          final FieldMetadata? metadata = metadataList
              .where((FieldMetadata m) => m.fieldPath == fieldPath)
              .firstOrNull;
          return Right<Failure, FieldMetadata?>(metadata);
        },
      );

      // If we found metadata in file, return it
      final FieldMetadata? fileMeta = fileMetadata.fold(
        (Failure _) => null,
        (FieldMetadata? meta) => meta,
      );
      if (fileMeta != null) {
        return Right<Failure, FieldMetadata?>(fileMeta);
      }

      // Last resort: try to get metadata from learned patterns
      if (patternRepository != null) {
        // Extract field name from path (last segment)
        final List<String> pathParts = fieldPath.split('.');
        final String fieldName = pathParts.isNotEmpty
            ? pathParts.last
            : fieldPath;

        final Either<Failure, List<ConfigPattern>> patternsResult =
            await patternRepository!.getPatternsForField(fieldName);

        return patternsResult.fold(
          (Failure failure) => const Right<Failure, FieldMetadata?>(null),
          (List<ConfigPattern> patterns) {
            if (patterns.isEmpty) {
              return const Right<Failure, FieldMetadata?>(null);
            }

            // Get the pattern with highest confidence and most occurrences
            patterns.sort((ConfigPattern a, ConfigPattern b) {
              final double scoreA = a.confidence * a.occurrences;
              final double scoreB = b.confidence * b.occurrences;
              return scoreB.compareTo(scoreA);
            });

            final ConfigPattern bestPattern = patterns.first;

            // Only return if confidence is reasonable (>= 0.3)
            if (bestPattern.confidence >= 0.3) {
              // Update field path to match the requested path
              final FieldMetadata patternMetadata = bestPattern.metadata.copyWith(
                fieldPath: fieldPath,
              );
              return Right<Failure, FieldMetadata?>(patternMetadata);
            }

            return const Right<Failure, FieldMetadata?>(null);
          },
        );
      }

      return const Right<Failure, FieldMetadata?>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error getting field metadata',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      return Left<Failure, FieldMetadata?>(
        UnexpectedFailure('Failed to get field metadata: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<FieldMetadata>>> mergeMetadata(
    String configFilePath,
    List<FieldMetadata> learnedMetadata,
  ) async {
    try {
      final Either<Failure, List<FieldMetadata>> existingResult =
          await loadMetadata(configFilePath);
      return existingResult.fold(
        (Failure failure) => Left<Failure, List<FieldMetadata>>(failure),
        (List<FieldMetadata> existing) async {
          final List<FieldMetadata> merged = <FieldMetadata>[];
          final Set<String> existingPaths = existing
              .map<String>((FieldMetadata e) => e.fieldPath)
              .toSet();

          // Add existing metadata
          merged.addAll(existing);

          // Add learned metadata that doesn't exist and save to database
          for (final FieldMetadata learned in learnedMetadata) {
            if (!existingPaths.contains(learned.fieldPath)) {
              merged.add(learned);
              await _saveToDatabase(learned);
            }
          }

          return Right<Failure, List<FieldMetadata>>(merged);
        },
      );
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error merging metadata',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      return Left<Failure, List<FieldMetadata>>(
        UnexpectedFailure('Failed to merge metadata: $e'),
      );
    }
  }

  // ==================== Private Helper Methods ====================

  /// Loads metadata from external .metadata.json file.
  Future<Either<Failure, List<FieldMetadata>>> _loadFromFile(
    String filePath,
  ) async {
    try {
      final String metadataPath = fileRepository.getMetadataPath(filePath);
      final Either<Failure, bool> existsResult = await fileRepository
          .fileExists(metadataPath);

      return existsResult.fold(
        (Failure failure) => Left<Failure, List<FieldMetadata>>(failure),
        (bool exists) async {
          if (!exists) {
            return const Right<Failure, List<FieldMetadata>>(<FieldMetadata>[]);
          }

          final Either<Failure, String> readResult = await fileRepository
              .readFile(metadataPath);
          return readResult.fold(
            (Failure failure) => Left<Failure, List<FieldMetadata>>(failure),
            (String content) {
              try {
                final Map<String, dynamic> json =
                    jsonDecode(content) as Map<String, dynamic>;
                final List<FieldMetadata> metadataList =
                    (json['metadata'] as List<dynamic>)
                        .map<FieldMetadata>(
                          (dynamic m) => _fromJson(m as Map<String, dynamic>),
                        )
                        .toList();
                return Right<Failure, List<FieldMetadata>>(metadataList);
              } on Object catch (e, stackTrace) {
                Logger.error(
                  'Failed to parse metadata JSON',
                  error: e,
                  stackTrace: stackTrace,
                  name: 'MetadataRepository',
                );
                return Left<Failure, List<FieldMetadata>>(
                  ParseFailure('Invalid metadata format: $e'),
                );
              }
            },
          );
        },
      );
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Unexpected error loading from file',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      return Left<Failure, List<FieldMetadata>>(
        UnexpectedFailure('Failed to load from file: $e'),
      );
    }
  }

  /// Saves metadata to the database.
  Future<void> _saveToDatabase(FieldMetadata metadata) async {
    try {
      final FieldMetadataTableCompanion companion =
          FieldMetadataMapper.toCompanion(metadata);
      final int metadataId = await metadataDao.upsertMetadata(companion);

      // Save constraints
      if (metadata.constraints.isNotEmpty) {
        // Delete old constraints first
        await metadataDao.deleteConstraints(metadataId);

        // Add new constraints
        for (final MetadataConstraint constraint in metadata.constraints) {
          final MetadataConstraintsTableCompanion constraintCompanion =
              FieldMetadataMapper.constraintToCompanion(metadataId, constraint);
          await metadataDao.addConstraint(constraintCompanion);
        }
      }
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error saving to database',
        error: e,
        stackTrace: stackTrace,
        name: 'MetadataRepository',
      );
      // Don't throw - just log the error
    }
  }

  FieldMetadata _fromJson(Map<String, dynamic> json) {
    // Simplified JSON parsing for file-based metadata
    return FieldMetadata(
      fieldPath: json['fieldPath'] as String,
      description: json['description'] as String?,
      tooltip: json['tooltip'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> _toJson(FieldMetadata metadata) {
    return <String, dynamic>{
      'fieldPath': metadata.fieldPath,
      'description': metadata.description,
      'tooltip': metadata.tooltip,
      'confidence': metadata.confidence,
    };
  }
}
