import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/file_repository.dart';

/// Use case for saving a file.
class SaveFile {
  /// Creates a new SaveFile use case.
  const SaveFile(this.repository);

  /// The file repository.
  final FileRepository repository;

  /// Saves content to a file.
  Future<Either<Failure, void>> call(String filePath, String content) {
    return repository.writeFile(filePath, content);
  }
}

