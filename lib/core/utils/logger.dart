import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Application logger utility.
///
/// Provides structured logging with different log levels.
/// Uses dart:developer for better debugging experience.
class Logger {
  Logger._();

  /// Log an informational message.
  static void info(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'INFO',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log a warning message.
  static void warning(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'WARNING',
        level: 900,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log an error message.
  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name ?? 'ERROR',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a debug message (only in debug mode).
  static void debug(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? 'DEBUG',
        level: 500,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

