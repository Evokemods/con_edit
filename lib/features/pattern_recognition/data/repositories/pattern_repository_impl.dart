import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../../config_editor/domain/entities/config_value_type.dart';
import '../../../metadata_management/data/datasources/metadata_dao.dart';
import '../../../metadata_management/data/models/field_metadata_mapper.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../metadata_management/domain/entities/metadata_constraint.dart';
import '../../domain/entities/config_pattern.dart';
import '../../domain/repositories/pattern_repository.dart';
import '../datasources/pattern_dao.dart';

/// Implementation of PatternRepository using Drift database.
class PatternRepositoryImpl implements PatternRepository {
  /// Creates a new PatternRepositoryImpl.
  const PatternRepositoryImpl(this.patternDao, this.metadataDao);

  /// Pattern DAO for database operations.
  final PatternDao patternDao;

  /// Metadata DAO for accessing metadata.
  final MetadataDao metadataDao;

  /// UUID generator for pattern IDs.
  static const Uuid _uuid = Uuid();

  @override
  Future<Either<Failure, List<ConfigPattern>>> analyzeConfig(
    Map<String, dynamic> config, {
    String? pluginName,
    String? configType,
  }) async {
    try {
      final List<ConfigPattern> patterns = <ConfigPattern>[];

      // Recursively analyze the config structure
      await _analyzeNode(
        config,
        '',
        patterns,
        pluginName: pluginName,
        configType: configType,
      );

      return Right<Failure, List<ConfigPattern>>(patterns);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error analyzing config',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, List<ConfigPattern>>(
        UnexpectedFailure('Failed to analyze config: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ConfigPattern>>> getPatternsForField(
    String fieldName,
  ) async {
    try {
      final List<ConfigPatternRow> rows = await patternDao.getPatternsByField(
        fieldName,
      );

      final List<ConfigPattern> patterns = <ConfigPattern>[];
      for (final ConfigPatternRow row in rows) {
        final ConfigPattern? pattern = await _rowToPattern(row);
        if (pattern != null) {
          patterns.add(pattern);
        }
      }

      return Right<Failure, List<ConfigPattern>>(patterns);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error getting patterns for field',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, List<ConfigPattern>>(
        UnexpectedFailure('Failed to get patterns: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> savePattern(ConfigPattern pattern) async {
    try {
      // Save metadata first if not already saved
      int? metadataId;
      final FieldMetadataTableCompanion metadataCompanion =
          FieldMetadataMapper.toCompanion(pattern.metadata);
      metadataId = await metadataDao.upsertMetadata(metadataCompanion);

      // Save constraints if any
      if (pattern.metadata.constraints.isNotEmpty) {
        await metadataDao.deleteConstraints(metadataId);
        for (final MetadataConstraint constraint
            in pattern.metadata.constraints) {
          final MetadataConstraintsTableCompanion constraintCompanion =
              FieldMetadataMapper.constraintToCompanion(metadataId, constraint);
          await metadataDao.addConstraint(constraintCompanion);
        }
      }

      // Check if a similar pattern already exists
      final ConfigPatternRow? existingPattern = await patternDao
          .findExistingPattern(
            fieldName: pattern.fieldName,
            pluginName: pattern.pluginName,
            configType: pattern.configType,
            metadataId: metadataId,
          );

      if (existingPattern != null) {
        // Update existing pattern: increment occurrences and update confidence
        final int newOccurrences =
            existingPattern.occurrences + pattern.occurrences;
        // Increase confidence slightly with each occurrence (capped at 0.95)
        final double newConfidence =
            (existingPattern.confidence * 0.9 + pattern.confidence * 0.1).clamp(
              0.0,
              0.95,
            );

        await patternDao.updatePattern(
          existingPattern.id,
          ConfigPatternsTableCompanion(
            occurrences: Value<int>(newOccurrences),
            confidence: Value<double>(newConfidence),
            lastSeen: Value<DateTime>(pattern.lastSeen ?? DateTime.now()),
          ),
        );
      } else {
        // Create new pattern
        final ConfigPatternsTableCompanion patternCompanion =
            ConfigPatternsTableCompanion.insert(
              id: pattern.id,
              fieldName: pattern.fieldName,
              pluginName: Value<String?>(pattern.pluginName),
              configType: Value<String?>(pattern.configType),
              confidence: pattern.confidence,
              occurrences: Value<int>(pattern.occurrences),
              lastSeen: pattern.lastSeen ?? DateTime.now(),
              metadataId: Value<int?>(metadataId),
            );

        await patternDao.insertPattern(patternCompanion);
      }

      return const Right<Failure, void>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error saving pattern',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, void>(
        UnexpectedFailure('Failed to save pattern: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ConfigPattern>>> getAllPatterns() async {
    try {
      final List<ConfigPatternRow> rows = await patternDao.getAllPatterns();

      final List<ConfigPattern> patterns = <ConfigPattern>[];
      for (final ConfigPatternRow row in rows) {
        final ConfigPattern? pattern = await _rowToPattern(row);
        if (pattern != null) {
          patterns.add(pattern);
        }
      }

      return Right<Failure, List<ConfigPattern>>(patterns);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error getting all patterns',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, List<ConfigPattern>>(
        UnexpectedFailure('Failed to get patterns: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updatePatternConfidence(
    String patternId,
    double confidence,
  ) async {
    try {
      await patternDao.updatePatternConfidence(patternId, confidence);
      return const Right<Failure, void>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error updating pattern confidence',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, void>(
        UnexpectedFailure('Failed to update confidence: $e'),
      );
    }
  }

  // ==================== Private Helper Methods ====================

  /// Recursively analyzes a config node to extract patterns.
  Future<void> _analyzeNode(
    dynamic node,
    String currentPath,
    List<ConfigPattern> patterns, {
    String? pluginName,
    String? configType,
  }) async {
    if (node is Map<String, dynamic>) {
      for (final MapEntry<String, dynamic> entry in node.entries) {
        final String fieldName = entry.key;
        final dynamic value = entry.value;
        final String fieldPath = currentPath.isEmpty
            ? fieldName
            : '$currentPath.$fieldName';

        // Track field statistics
        await patternDao.incrementFieldFrequency(fieldName: fieldName);

        // Infer metadata from the value and create a pattern
        final FieldMetadata? metadata = _inferMetadata(value, fieldPath);
        if (metadata != null) {
          final ConfigPattern pattern = ConfigPattern(
            id: _uuid.v4(),
            fieldName: fieldName,
            metadata: metadata,
            confidence: 0.5, // Start with medium confidence
            occurrences: 1,
            pluginName: pluginName,
            configType: configType,
            lastSeen: DateTime.now(),
          );
          patterns.add(pattern);
        }

        // Recursively analyze nested structures
        await _analyzeNode(
          value,
          fieldPath,
          patterns,
          pluginName: pluginName,
          configType: configType,
        );
      }
    } else if (node is List) {
      // Analyze array patterns
      for (final dynamic item in node) {
        await _analyzeNode(
          item,
          currentPath,
          patterns,
          pluginName: pluginName,
          configType: configType,
        );
      }
    }
  }

  /// Infers metadata from a value.
  FieldMetadata? _inferMetadata(dynamic value, String fieldPath) {
    final ConfigValueType? valueType = _inferValueType(value);
    if (valueType == null) {
      return null;
    }

    final List<MetadataConstraint> constraints = <MetadataConstraint>[];

    // Infer constraints based on value type
    if (valueType.isNumeric && value is num) {
      // For numeric values, we could infer min/max from the value itself
      // but we'll leave that for future enhancement
    } else if (valueType == ConfigValueType.string && value is String) {
      // For strings, infer length constraints
      if (value.isNotEmpty) {
        constraints.add(
          const MetadataConstraint(
            type: ConstraintType.minLength,
            minLength: 1,
          ),
        );
      }
    }

    return FieldMetadata(
      fieldPath: fieldPath,
      valueType: valueType,
      constraints: constraints,
      confidence: 0.5, // Learned metadata has lower confidence
    );
  }

  /// Infers ConfigValueType from a dynamic value.
  ConfigValueType? _inferValueType(dynamic value) {
    if (value == null) {
      return ConfigValueType.nullValue;
    }
    if (value is bool) {
      return ConfigValueType.boolean;
    }
    if (value is int) {
      return ConfigValueType.integer;
    }
    if (value is double) {
      return ConfigValueType.double;
    }
    if (value is String) {
      return ConfigValueType.string;
    }
    if (value is List) {
      return ConfigValueType.array;
    }
    if (value is Map) {
      return ConfigValueType.object;
    }
    return null;
  }

  /// Converts a database row to a ConfigPattern entity.
  Future<ConfigPattern?> _rowToPattern(ConfigPatternRow row) async {
    try {
      FieldMetadata? metadata;

      if (row.metadataId != null) {
        final List<FieldMetadataWithConstraints> metadataWithConstraints =
            await metadataDao.getMetadataWithConstraints(row.fieldName);

        if (metadataWithConstraints.isNotEmpty) {
          final FieldMetadataWithConstraints mwc =
              metadataWithConstraints.first;
          metadata = FieldMetadataMapper.fromRow(mwc.metadata, mwc.constraints);
        }
      }

      return ConfigPattern(
        id: row.id,
        fieldName: row.fieldName,
        metadata:
            metadata ?? const FieldMetadata(fieldPath: '', confidence: 0.5),
        confidence: row.confidence,
        occurrences: row.occurrences,
        pluginName: row.pluginName,
        configType: row.configType,
        lastSeen: row.lastSeen,
      );
    } catch (e, stackTrace) {
      Logger.error(
        'Error converting row to pattern',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return null;
    }
  }

  /// Creates a new pattern ID.
  static String generatePatternId() {
    return _uuid.v4();
  }

  @override
  Future<Either<Failure, void>> clearAllPatterns() async {
    try {
      await patternDao.deleteAllPatterns();
      await patternDao.deleteAllFieldStatistics();
      return const Right<Failure, void>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error clearing patterns',
        error: e,
        stackTrace: stackTrace,
        name: 'PatternRepository',
      );
      return Left<Failure, void>(
        UnexpectedFailure('Failed to clear patterns: $e'),
      );
    }
  }
}
