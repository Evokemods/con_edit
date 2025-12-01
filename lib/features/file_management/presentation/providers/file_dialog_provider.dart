import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/open_file.dart';
import '../../domain/usecases/save_file.dart';
import 'file_provider.dart';

/// Provider for file dialog operations.
final Provider<FileDialogService> fileDialogProvider = Provider<FileDialogService>((Ref ref) {
  final OpenFile openFile = ref.watch(openFileProvider);
  final SaveFile saveFile = ref.watch(saveFileProvider);
  return FileDialogService(openFile: openFile, saveFile: saveFile);
});

/// Service for handling file dialogs.
class FileDialogService {
  /// Creates a new FileDialogService.
  const FileDialogService({
    required this.openFile,
    required this.saveFile,
  });

  /// Open file use case.
  final OpenFile openFile;

  /// Save file use case.
  final SaveFile saveFile;

  /// Opens a file picker dialog and loads the selected file.
  Future<FileDialogResult?> pickAndOpenFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: <String>[AppConstants.jsonExtension.substring(1)],
        dialogTitle: 'Open Config File',
      );

      if (result != null && result.files.single.path != null) {
        final String filePath = result.files.single.path!;
        final Either<Failure, String> contentResult = await openFile(filePath);

        return contentResult.fold(
          (Failure failure) => FileDialogResult(
            success: false,
            filePath: filePath,
            error: failure.message ?? 'Failed to open file',
          ),
          (String content) => FileDialogResult(
            success: true,
            filePath: filePath,
            content: content,
          ),
        );
      }

      return null;
    } catch (e) {
      return FileDialogResult(
        success: false,
        error: 'Failed to open file picker: $e',
      );
    }
  }

  /// Opens a save file dialog and saves the content.
  Future<FileDialogResult?> pickAndSaveFile(String content) async {
    try {
      final String? result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Config File',
        fileName: 'config.json',
        type: FileType.custom,
        allowedExtensions: <String>[AppConstants.jsonExtension.substring(1)],
      );

      if (result != null) {
        final Either<Failure, void> saveResult = await saveFile(result, content);

        return saveResult.fold(
          (Failure failure) => FileDialogResult(
            success: false,
            filePath: result,
            error: failure.message ?? 'Failed to save file',
          ),
          (void _) => FileDialogResult(
            success: true,
            filePath: result,
          ),
        );
      }

      return null;
    } catch (e) {
      return FileDialogResult(
        success: false,
        error: 'Failed to open save dialog: $e',
      );
    }
  }

  /// Opens a directory picker dialog and returns the selected directory path.
  Future<FileDialogResult?> pickDirectory({String? dialogTitle}) async {
    try {
      final String? result = await FilePicker.platform.getDirectoryPath(
        dialogTitle: dialogTitle ?? 'Select Config Directory',
      );

      if (result != null) {
        return FileDialogResult(
          success: true,
          filePath: result,
        );
      }

      return null;
    } catch (e) {
      return FileDialogResult(
        success: false,
        error: 'Failed to open directory picker: $e',
      );
    }
  }
}

/// Result of a file dialog operation.
class FileDialogResult {
  /// Creates a new FileDialogResult.
  const FileDialogResult({
    required this.success,
    this.filePath,
    this.content,
    this.error,
  });

  /// Whether the operation was successful.
  final bool success;

  /// Path to the file.
  final String? filePath;

  /// File content (for open operations).
  final String? content;

  /// Error message if operation failed.
  final String? error;
}
