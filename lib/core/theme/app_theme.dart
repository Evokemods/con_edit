import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// Application theme configuration.
///
/// Provides a dark theme based on design tokens with comprehensive styling.
class AppTheme {
  AppTheme._();

  /// Dark theme configuration (primary theme).
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: DesignTokens.fontFamily,
        primaryColor: DesignTokens.primaryColor,
        scaffoldBackgroundColor: DesignTokens.backgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: DesignTokens.primaryColor,
          secondary: DesignTokens.secondaryColor,
          surface: DesignTokens.surfaceColor,
          error: DesignTokens.errorColor,
          onPrimary: DesignTokens.onSurfaceColor,
          onSecondary: DesignTokens.onSurfaceColor,
          onError: DesignTokens.onSurfaceColor,
        ),
        textTheme: TextTheme(
          displayLarge: DesignTokens.displayLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          displayMedium: DesignTokens.displayMedium.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          displaySmall: DesignTokens.displaySmall.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          headlineLarge: DesignTokens.headlineLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          headlineMedium: DesignTokens.headlineMedium.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          headlineSmall: DesignTokens.headlineSmall.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          titleLarge: DesignTokens.titleLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          titleMedium: DesignTokens.titleMedium.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          titleSmall: DesignTokens.titleSmall.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          bodyLarge: DesignTokens.bodyLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          bodyMedium: DesignTokens.bodyMedium.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          bodySmall: DesignTokens.bodySmall.copyWith(
            color: DesignTokens.onSurfaceVariantColor,
          ),
          labelLarge: DesignTokens.labelLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          labelMedium: DesignTokens.labelMedium.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
          labelSmall: DesignTokens.labelSmall.copyWith(
            color: DesignTokens.onSurfaceVariantColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: DesignTokens.surfaceColor,
          foregroundColor: DesignTokens.onSurfaceColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: DesignTokens.titleLarge.copyWith(
            color: DesignTokens.onSurfaceColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: DesignTokens.primaryColor,
            foregroundColor: DesignTokens.onSurfaceColor,
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space200,
              vertical: DesignTokens.space100,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            ),
            elevation: DesignTokens.elevationLow,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: DesignTokens.primaryColor,
            side: const BorderSide(
              color: DesignTokens.primaryColor,
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space200,
              vertical: DesignTokens.space100,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: DesignTokens.primaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space200,
              vertical: DesignTokens.space100,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(
              color: DesignTokens.dividerColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(
              color: DesignTokens.dividerColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(
              color: DesignTokens.primaryColor,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(
              color: DesignTokens.errorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
            borderSide: const BorderSide(
              color: DesignTokens.errorColor,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: DesignTokens.surfaceVariantColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.space200,
            vertical: DesignTokens.space150,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: DesignTokens.elevationLow,
          color: DesignTokens.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          ),
        ),
        dividerTheme: const DividerThemeData(
          thickness: 1,
          color: DesignTokens.dividerColor,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return DesignTokens.primaryColor;
            }
            return DesignTokens.onSurfaceVariantColor;
          }),
          trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return DesignTokens.primaryColor.withValues(alpha: 0.5);
            }
            return DesignTokens.dividerColor;
          }),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return DesignTokens.primaryColor;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(DesignTokens.onSurfaceColor),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: DesignTokens.primaryColor,
          inactiveTrackColor: DesignTokens.dividerColor,
          thumbColor: DesignTokens.primaryColor,
          overlayColor: Color(0x29CE422B),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: DesignTokens.surfaceColor,
          elevation: DesignTokens.elevationHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          ),
        ),
      );
}
