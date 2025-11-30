import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/field_metadata.dart';
import '../repositories/metadata_repository.dart';

/// Use case for getting metadata for a specific field.
class GetFieldMetadata {
  /// Creates a new GetFieldMetadata use case.
  const GetFieldMetadata(this.repository);

  /// The metadata repository.
  final MetadataRepository repository;

  /// Gets metadata for a field path.
  ///
  /// Returns null if no metadata exists for the field.
  Future<Either<Failure, FieldMetadata?>> call({
    required String configFilePath,
    required String fieldPath,
  }) async {
    return repository.getFieldMetadata(configFilePath, fieldPath);
  }
}
