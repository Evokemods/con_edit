import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/config_pattern.dart';

/// Repository interface for pattern recognition operations.
abstract class PatternRepository {
  /// Analyzes a config and extracts patterns.
  Future<Either<Failure, List<ConfigPattern>>> analyzeConfig(
    Map<String, dynamic> config, {
    String? pluginName,
    String? configType,
  });

  /// Gets patterns for a specific field name.
  Future<Either<Failure, List<ConfigPattern>>> getPatternsForField(
    String fieldName,
  );

  /// Saves a learned pattern.
  Future<Either<Failure, void>> savePattern(ConfigPattern pattern);

  /// Gets all learned patterns.
  Future<Either<Failure, List<ConfigPattern>>> getAllPatterns();

  /// Updates pattern confidence based on user feedback.
  Future<Either<Failure, void>> updatePatternConfidence(
    String patternId,
    double confidence,
  );

  /// Clears all patterns and field statistics.
  Future<Either<Failure, void>> clearAllPatterns();
}
