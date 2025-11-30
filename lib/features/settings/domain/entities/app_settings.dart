import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show ThemeMode;

/// Application settings.
class AppSettings extends Equatable {
  /// Creates new app settings.
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.windowWidth,
    this.windowHeight,
    this.windowX,
    this.windowY,
    this.autoSave = false,
    this.autoSaveInterval = 30,
    this.recentFiles = const <String>[],
    this.documentationSources = const <String, String>{},
  });

  /// Theme mode preference.
  final ThemeMode themeMode;

  /// Window width (for persistence).
  final double? windowWidth;

  /// Window height (for persistence).
  final double? windowHeight;

  /// Window X position (for persistence).
  final double? windowX;

  /// Window Y position (for persistence).
  final double? windowY;

  /// Whether auto-save is enabled.
  final bool autoSave;

  /// Auto-save interval in seconds.
  final int autoSaveInterval;

  /// List of recently opened files.
  final List<String> recentFiles;

  /// Documentation sources by plugin name.
  final Map<String, String> documentationSources;

  /// Creates a copy with updated fields.
  AppSettings copyWith({
    ThemeMode? themeMode,
    double? windowWidth,
    double? windowHeight,
    double? windowX,
    double? windowY,
    bool? autoSave,
    int? autoSaveInterval,
    List<String>? recentFiles,
    Map<String, String>? documentationSources,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      windowWidth: windowWidth ?? this.windowWidth,
      windowHeight: windowHeight ?? this.windowHeight,
      windowX: windowX ?? this.windowX,
      windowY: windowY ?? this.windowY,
      autoSave: autoSave ?? this.autoSave,
      autoSaveInterval: autoSaveInterval ?? this.autoSaveInterval,
      recentFiles: recentFiles ?? this.recentFiles,
      documentationSources: documentationSources ?? this.documentationSources,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        windowWidth,
        windowHeight,
        windowX,
        windowY,
        autoSave,
        autoSaveInterval,
        recentFiles,
        documentationSources,
      ];
}
