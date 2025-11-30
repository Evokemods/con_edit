import 'package:flutter/material.dart';

/// Application text styles.
///
/// Centralized typography definitions for consistent text styling.
class AppTextStyles {
  AppTextStyles._();

  // Headlines
  /// Largest headline style (32px, bold).
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// Large headline style (28px, bold).
  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// Medium headline style (24px, semi-bold).
  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  /// Small headline style (20px, semi-bold).
  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Body text
  /// Primary body text style (16px, normal).
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  /// Secondary body text style (14px, normal).
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// Small body text style (12px, normal).
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Labels
  /// Large label style (14px, medium weight).
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Medium label style (12px, medium weight).
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// Small label style (10px, medium weight).
  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  // Code/Monospace
  /// Monospace code style (14px, monospace font).
  static const TextStyle code = TextStyle(
    fontSize: 14,
    fontFamily: 'monospace',
    fontWeight: FontWeight.normal,
  );
}

