import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as path;

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/file_repository.dart';

/// Implementation of FileRepository.
class FileRepositoryImpl implements FileRepository {
  /// Creates a new FileRepositoryImpl.
  const FileRepositoryImpl();

  @override
  Future<Either<Failure, String>> readFile(String filePath) async {
    try {
      final File file = File(filePath);
      // ignore: avoid_slow_async_io
      if (!await file.exists()) {
        return Left<Failure, String>(
          FileFailure('File does not exist: $filePath'),
        );
      }
      final String content = await file.readAsString();
      return Right<Failure, String>(content);
    } on FileSystemException catch (e, stackTrace) {
      Logger.error(
        'Failed to read file',
        error: e,
        stackTrace: stackTrace,
        name: 'FileRepository',
      );
      return Left<Failure, String>(
        FileFailure('Failed to read file: ${e.message}'),
      );
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Unexpected error reading file',
        error: e,
        stackTrace: stackTrace,
        name: 'FileRepository',
      );
      return Left<Failure, String>(
        UnexpectedFailure('Failed to read file: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> writeFile(
    String filePath,
    String content,
  ) async {
    try {
      final File file = File(filePath);
      final String directory = path.dirname(filePath);
      final Directory dir = Directory(directory);
      // ignore: avoid_slow_async_io
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      await file.writeAsString(content);
      return const Right<Failure, void>(null);
    } on FileSystemException catch (e, stackTrace) {
      Logger.error(
        'Failed to write file',
        error: e,
        stackTrace: stackTrace,
        name: 'FileRepository',
      );
      return Left<Failure, void>(
        FileFailure('Failed to write file: ${e.message}'),
      );
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Unexpected error writing file',
        error: e,
        stackTrace: stackTrace,
        name: 'FileRepository',
      );
      return Left<Failure, void>(UnexpectedFailure('Failed to write file: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> fileExists(String filePath) async {
    try {
      final File file = File(filePath);
      // ignore: avoid_slow_async_io
      return Right<Failure, bool>(await file.exists());
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Error checking file existence',
        error: e,
        stackTrace: stackTrace,
        name: 'FileRepository',
      );
      return Left<Failure, bool>(UnexpectedFailure('Failed to check file: $e'));
    }
  }

  @override
  String getMetadataPath(String configFilePath) {
    return configFilePath.replaceAll(
      AppConstants.jsonExtension,
      AppConstants.metadataExtension,
    );
  }

  @override
  String getDirectory(String filePath) {
    return path.dirname(filePath);
  }

  @override
  String getFileName(String filePath) {
    return path.basename(filePath);
  }
}
