import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../file_management/presentation/providers/file_dialog_provider.dart';
import '../../../settings/domain/entities/app_settings.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../providers/config_provider.dart';

/// Notifier for auto-save functionality.
class AutoSaveNotifier extends StateNotifier<bool> {
  /// Creates a new AutoSaveNotifier.
  AutoSaveNotifier({
    required this.configNotifier,
    required this.fileDialog,
    required this.settings,
  }) : super(false) {
    _startAutoSave();
  }

  /// Config editor notifier.
  final ConfigEditorNotifier configNotifier;

  /// File dialog service.
  final FileDialogService fileDialog;

  /// Settings (for auto-save config).
  final AppSettings settings;

  Timer? _timer;
  String? _lastSavedPath;

  /// Starts the auto-save timer.
  void _startAutoSave() {
    if (!settings.autoSave) {
      return;
    }

    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(seconds: settings.autoSaveInterval),
      (_) => _performAutoSave(),
    );
  }

  /// Performs auto-save if there are unsaved changes.
  Future<void> _performAutoSave() async {
    if (!settings.autoSave || _lastSavedPath == null) {
      return;
    }

    final String? jsonString = await configNotifier.toJsonString();
    if (jsonString != null) {
      final FileDialogResult? result = await fileDialog.pickAndSaveFile(jsonString);
      if (result != null && result.success && result.filePath != null) {
        _lastSavedPath = result.filePath;
        state = true;
        // Reset after a short delay
        Future<void>.delayed(const Duration(seconds: 2), () {
          state = false;
        });
      }
    }
  }

  /// Sets the file path for auto-save.
  void setFilePath(String? filePath) {
    _lastSavedPath = filePath;
  }

  /// Updates auto-save settings.
  void updateSettings(AppSettings newSettings) {
    _startAutoSave();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider for auto-save functionality.
final StateNotifierProvider<AutoSaveNotifier, bool> autoSaveProvider =
    StateNotifierProvider<AutoSaveNotifier, bool>((Ref ref) {
  final ConfigEditorNotifier configNotifier = ref.watch(configEditorProvider.notifier);
  final FileDialogService fileDialog = ref.watch(fileDialogProvider);
  final AppSettings settings = ref.watch(settingsProvider);
  return AutoSaveNotifier(
    configNotifier: configNotifier,
    fileDialog: fileDialog,
    settings: settings,
  );
});
