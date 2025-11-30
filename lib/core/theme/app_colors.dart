import 'package:flutter/material.dart';

/// Application color palette.
///
/// Centralized color definitions for consistent theming across the app.
class AppColors {
  AppColors._();

  // Primary colors
  /// Primary brand color.
  static const Color primary = Color(0xFF2196F3);
  /// Dark variant of primary color.
  static const Color primaryDark = Color(0xFF1976D2);
  /// Light variant of primary color.
  static const Color primaryLight = Color(0xFFBBDEFB);

  // Accent colors
  /// Accent color for highlights.
  static const Color accent = Color(0xFFFF5722);
  /// Light variant of accent color.
  static const Color accentLight = Color(0xFFFF8A65);

  // Neutral colors
  /// White color.
  static const Color white = Color(0xFFFFFFFF);
  /// Black color.
  static const Color black = Color(0xFF000000);
  /// Grey color.
  static const Color grey = Color(0xFF9E9E9E);
  /// Light grey color.
  static const Color greyLight = Color(0xFFE0E0E0);
  /// Dark grey color.
  static const Color greyDark = Color(0xFF616161);

  // Status colors
  /// Success status color.
  static const Color success = Color(0xFF4CAF50);
  /// Warning status color.
  static const Color warning = Color(0xFFFFC107);
  /// Error status color.
  static const Color error = Color(0xFFF44336);
  /// Info status color.
  static const Color info = Color(0xFF2196F3);

  // Background colors (light theme)
  /// Background color for light theme.
  static const Color background = Color(0xFFF5F5F5);
  /// Surface color for light theme.
  static const Color surface = Color(0xFFFFFFFF);
  /// Variant surface color for light theme.
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // Background colors (dark theme)
  /// Background color for dark theme.
  static const Color backgroundDark = Color(0xFF121212);
  /// Surface color for dark theme.
  static const Color surfaceDark = Color(0xFF1E1E1E);
  /// Variant surface color for dark theme.
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);
}

