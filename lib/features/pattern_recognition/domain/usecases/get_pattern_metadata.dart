import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';
import '../../domain/entities/config_pattern.dart';
import '../../domain/repositories/pattern_repository.dart';

/// Use case for getting metadata from learned patterns.
///
/// When a field doesn't have explicit metadata, this use case
/// looks up learned patterns to suggest metadata based on field name.
class GetPatternMetadata {
  /// Creates a new GetPatternMetadata use case.
  const GetPatternMetadata(this.patternRepository);

  /// Pattern repository.
  final PatternRepository patternRepository;

  /// Gets suggested metadata for a field based on learned patterns.
  ///
  /// Returns the highest confidence pattern for the given field name,
  /// or null if no patterns are found.
  Future<Either<Failure, FieldMetadata?>> getMetadataForField(
    String fieldName,
  ) async {
    final Either<Failure, List<ConfigPattern>> patternsResult =
        await patternRepository.getPatternsForField(fieldName);

    return patternsResult.fold(
      (Failure failure) => Left<Failure, FieldMetadata?>(failure),
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

        // Only return if confidence is reasonable
        if (bestPattern.confidence >= 0.3) {
          return Right<Failure, FieldMetadata?>(bestPattern.metadata);
        }

        return const Right<Failure, FieldMetadata?>(null);
      },
    );
  }
}

