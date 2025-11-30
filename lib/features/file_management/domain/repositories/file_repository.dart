import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';

/// Repository interface for file operations.
abstract class FileRepository {
  /// Opens a file and returns its contents.
  Future<Either<Failure, String>> readFile(String filePath);

  /// Writes content to a file.
  Future<Either<Failure, void>> writeFile(String filePath, String content);

  /// Checks if a file exists.
  Future<Either<Failure, bool>> fileExists(String filePath);

  /// Gets the metadata file path for a given config file.
  String getMetadataPath(String configFilePath);

  /// Gets the directory of a file.
  String getDirectory(String filePath);

  /// Gets the file name from a path.
  String getFileName(String filePath);
}
