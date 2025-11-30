import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Provider for the SettingsRepository.
final Provider<SettingsRepository> settingsRepositoryProvider =
    Provider<SettingsRepository>((Ref ref) {
      // This will be provided via override in main
      throw UnimplementedError(
        'SettingsRepository must be provided via override',
      );
    });

/// Notifier for app settings.
class SettingsNotifier extends StateNotifier<AppSettings> {
  /// Creates a new SettingsNotifier.
  SettingsNotifier(this.repository) : super(const AppSettings()) {
    _loadSettings();
  }

  /// Settings repository.
  final SettingsRepository repository;

  /// Loads settings from storage.
  Future<void> _loadSettings() async {
    final Either<Failure, AppSettings> result = await repository.loadSettings();
    result.fold(
      (Failure failure) {
        // Use default settings on error
      },
      (AppSettings settings) {
        state = settings;
      },
    );
  }

  /// Updates theme mode.
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await repository.saveSettings(state);
  }

  /// Updates window size and position.
  Future<void> updateWindowGeometry({
    double? width,
    double? height,
    double? x,
    double? y,
  }) async {
    state = state.copyWith(
      windowWidth: width ?? state.windowWidth,
      windowHeight: height ?? state.windowHeight,
      windowX: x ?? state.windowX,
      windowY: y ?? state.windowY,
    );
    await repository.saveSettings(state);
  }

  /// Updates auto-save settings.
  Future<void> updateAutoSave({bool? enabled, int? interval}) async {
    state = state.copyWith(
      autoSave: enabled ?? state.autoSave,
      autoSaveInterval: interval ?? state.autoSaveInterval,
    );
    await repository.saveSettings(state);
  }
}

/// Provider for the settings notifier.
final StateNotifierProvider<SettingsNotifier, AppSettings> settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((Ref ref) {
      final SettingsRepository repository = ref.watch(
        settingsRepositoryProvider,
      );
      return SettingsNotifier(repository);
    });
