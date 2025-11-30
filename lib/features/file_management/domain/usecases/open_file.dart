import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/file_repository.dart';

/// Use case for opening a file.
class OpenFile {
  /// Creates a new OpenFile use case.
  const OpenFile(this.repository);

  /// The file repository.
  final FileRepository repository;

  /// Opens a file and returns its contents.
  Future<Either<Failure, String>> call(String filePath) {
    return repository.readFile(filePath);
  }
}

