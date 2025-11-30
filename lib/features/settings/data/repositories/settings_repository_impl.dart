import 'dart:convert';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

/// Implementation of SettingsRepository using SharedPreferences.
class SettingsRepositoryImpl implements SettingsRepository {
  /// Creates a new SettingsRepositoryImpl.
  const SettingsRepositoryImpl(this.preferences);

  /// SharedPreferences instance.
  final SharedPreferences preferences;

  @override
  Future<Either<Failure, AppSettings>> loadSettings() async {
    try {
      final int themeModeIndex =
          preferences.getInt(AppConstants.keyThemeMode) ?? 0;
      final ThemeMode themeMode = ThemeMode.values[themeModeIndex.clamp(0, 2)];

      final double? windowWidth = preferences.getDouble(
        AppConstants.keyWindowWidth,
      );
      final double? windowHeight = preferences.getDouble(
        AppConstants.keyWindowHeight,
      );
      final double? windowX = preferences.getDouble(AppConstants.keyWindowX);
      final double? windowY = preferences.getDouble(AppConstants.keyWindowY);

      final bool autoSave =
          preferences.getBool(AppConstants.keyAutoSave) ?? false;
      final int autoSaveInterval =
          preferences.getInt(AppConstants.keyAutoSaveInterval) ??
          AppConstants.defaultAutoSaveInterval;

      final String? recentFilesJson = preferences.getString(
        AppConstants.keyRecentFiles,
      );
      final List<String> recentFiles = recentFilesJson != null
          ? (jsonDecode(recentFilesJson) as List<dynamic>)
                .map<String>((dynamic e) => e as String)
                .toList()
          : <String>[];

      final AppSettings settings = AppSettings(
        themeMode: themeMode,
        windowWidth: windowWidth,
        windowHeight: windowHeight,
        windowX: windowX,
        windowY: windowY,
        autoSave: autoSave,
        autoSaveInterval: autoSaveInterval,
        recentFiles: recentFiles,
      );

      return Right<Failure, AppSettings>(settings);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Failed to load settings',
        error: e,
        stackTrace: stackTrace,
        name: 'SettingsRepository',
      );
      return Left<Failure, AppSettings>(UnexpectedFailure('Failed to load settings: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(AppSettings settings) async {
    try {
      await preferences.setInt(
        AppConstants.keyThemeMode,
        settings.themeMode.index,
      );

      if (settings.windowWidth != null) {
        await preferences.setDouble(
          AppConstants.keyWindowWidth,
          settings.windowWidth!,
        );
      }

      if (settings.windowHeight != null) {
        await preferences.setDouble(
          AppConstants.keyWindowHeight,
          settings.windowHeight!,
        );
      }

      if (settings.windowX != null) {
        await preferences.setDouble(AppConstants.keyWindowX, settings.windowX!);
      }

      if (settings.windowY != null) {
        await preferences.setDouble(AppConstants.keyWindowY, settings.windowY!);
      }

      await preferences.setBool(AppConstants.keyAutoSave, settings.autoSave);
      await preferences.setInt(
        AppConstants.keyAutoSaveInterval,
        settings.autoSaveInterval,
      );

      await preferences.setString(
        AppConstants.keyRecentFiles,
        jsonEncode(settings.recentFiles),
      );

      return const Right<Failure, void>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Failed to save settings',
        error: e,
        stackTrace: stackTrace,
        name: 'SettingsRepository',
      );
      return Left<Failure, void>(UnexpectedFailure('Failed to save settings: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateSetting<T>(String key, T value) async {
    try {
      if (value is bool) {
        await preferences.setBool(key, value);
      } else if (value is int) {
        await preferences.setInt(key, value);
      } else if (value is double) {
        await preferences.setDouble(key, value);
      } else if (value is String) {
        await preferences.setString(key, value);
      } else {
        return const Left<Failure, void>(
          UnexpectedFailure('Unsupported setting type'),
        );
      }
      return const Right<Failure, void>(null);
    } on Object catch (e, stackTrace) {
      Logger.error(
        'Failed to update setting',
        error: e,
        stackTrace: stackTrace,
        name: 'SettingsRepository',
      );
      return Left<Failure, void>(
        UnexpectedFailure('Failed to update setting: $e'),
      );
    }
  }
}
