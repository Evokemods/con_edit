import 'package:flutter/material.dart';

/// Design tokens for the application.
///
/// This file contains all design constants (colors, spacing, typography, etc.)
/// that are used throughout the application. This ensures consistency and makes
/// it easy to update the design system.
class DesignTokens {
  DesignTokens._();

  // ==================== COLORS ====================

  /// Primary accent color - used for highlights, active states, borders.
  static const Color primaryColor = Color(0xFFCE422B);

  /// Secondary accent color - for alternative accents.
  static const Color secondaryColor = Color(0xFFE85D47);

  /// Main background color - scaffold background.
  static const Color backgroundColor = Color(0xFF121212);

  /// Surface color - cards, panels, elevated areas.
  static const Color surfaceColor = Color(0xFF1E1E1E);

  /// Surface variant - input fields, secondary containers.
  static const Color surfaceVariantColor = Color(0xFF2A2A2A);

  /// Primary text color on surfaces.
  static const Color onSurfaceColor = Color(0xFFFFFFFF);

  /// Secondary/hint text color.
  static const Color onSurfaceVariantColor = Color(0xFFB0B0B0);

  /// Divider color.
  static const Color dividerColor = Color(0xFF3A3A3A);

  /// Status Colors
  /// Success/positive action color.
  static const Color successColor = Color(0xFF10b981);

  /// Error/negative action color.
  static const Color errorColor = Color(0xFFef4444);

  /// Warning/caution color.
  static const Color warningColor = Color(0xFFf59e0b);

  // ==================== SPACING (8px scale) ====================

  /// 4px - smallest gaps.
  static const double space50 = 4.0;

  /// 8px - standard gaps.
  static const double space100 = 8.0;

  /// 12px - medium gaps.
  static const double space150 = 12.0;

  /// 16px - standard padding.
  static const double space200 = 16.0;

  /// 24px - section padding.
  static const double space300 = 24.0;

  /// 32px - large padding.
  static const double space400 = 32.0;

  /// 48px - xlarge padding.
  static const double space500 = 48.0;

  /// 64px - xxlarge padding.
  static const double space600 = 64.0;

  // ==================== BORDER RADIUS ====================

  /// 4px - subtle rounding.
  static const double radiusSmall = 4.0;

  /// 8px - standard rounding (most common).
  static const double radiusMedium = 8.0;

  /// 12px - larger rounding.
  static const double radiusLarge = 12.0;

  /// 16px - extra large rounding.
  static const double radiusExtraLarge = 16.0;

  // ==================== ELEVATION ====================

  /// 2px - subtle elevation.
  static const double elevationLow = 2.0;

  /// 4px - standard elevation.
  static const double elevationMedium = 4.0;

  /// 8px - prominent elevation.
  static const double elevationHigh = 8.0;

  // ==================== TYPOGRAPHY ====================

  /// Font family - Roboto Condensed for industrial feel.
  static const String fontFamily = 'Roboto Condensed';

  /// Display text styles (large headers).
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  /// Medium display text style (45px).
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  /// Small display text style (36px).
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  /// Headline text styles (section titles).
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  /// Medium headline text style (28px).
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  /// Small headline text style (24px).
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  /// Title text styles (field labels).
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  /// Medium title text style (16px).
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// Small title text style (14px).
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Body text styles (content text).
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  /// Medium body text style (14px).
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// Small body text style (12px).
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// Label text styles (badges, small labels).
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Medium label text style (12px).
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// Small label text style (11px).
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  // ==================== ANIMATION ====================

  /// Standard animation duration.
  static const Duration animationDuration = Duration(milliseconds: 200);

  /// Hover effect blur radius.
  static const double hoverBlurRadius = 12.0;

  // ==================== SIZES ====================

  /// Sidebar width.
  static const double sidebarWidth = 280.0;

  /// List panel width (for master-detail).
  static const double listPanelWidth = 350.0;

  /// Icon sizes.
  static const double iconSizeSmall = 16.0;

  /// Medium icon size (24px).
  static const double iconSizeMedium = 24.0;

  /// Large icon size (32px).
  static const double iconSizeLarge = 32.0;

  /// Badge size.
  static const double badgeSize = 32.0;

  /// Input field height.
  static const double inputHeight = 48.0;
}
