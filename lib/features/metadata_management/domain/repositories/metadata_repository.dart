import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/field_metadata.dart';

/// Repository interface for metadata operations.
abstract class MetadataRepository {
  /// Loads metadata for a config file.
  Future<Either<Failure, List<FieldMetadata>>> loadMetadata(String filePath);

  /// Saves metadata for a config file.
  Future<Either<Failure, void>> saveMetadata(
    String filePath,
    List<FieldMetadata> metadata,
  );

  /// Gets metadata for a specific field path.
  Future<Either<Failure, FieldMetadata?>> getFieldMetadata(
    String configFilePath,
    String fieldPath,
  );

  /// Merges learned metadata with existing metadata.
  Future<Either<Failure, List<FieldMetadata>>> mergeMetadata(
    String configFilePath,
    List<FieldMetadata> learnedMetadata,
  );
}
