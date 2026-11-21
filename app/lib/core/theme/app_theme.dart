import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.primary)
      .copyWith(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.accent,
        onSecondary: AppColors.onAccent,
        error: AppColors.error,
        onError: AppColors.onError,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      );

  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
  );
  const minimumSize = Size(
    AppSpacing.minTouchTarget,
    AppSpacing.minTouchTarget,
  );

  OutlineInputBorder outline(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme:
        const TextTheme(
          displaySmall: AppType.display,
          titleLarge: AppType.title,
          titleMedium: AppType.headline,
          bodyLarge: AppType.body,
          bodyMedium: AppType.body,
          bodySmall: AppType.caption,
          labelLarge: AppType.label,
          labelSmall: AppType.caption,
        ).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppType.title.copyWith(color: AppColors.textPrimary),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primary.withValues(alpha: 0.18),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return AppType.label.copyWith(
          color: selected ? AppColors.primaryText : AppColors.textSecondary,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        );
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.disabled,
        disabledForegroundColor: AppColors.onDisabled,
        minimumSize: minimumSize,
        textStyle: AppType.label,
        shape: shape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        disabledForegroundColor: AppColors.onDisabled,
        minimumSize: minimumSize,
        textStyle: AppType.label,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: shape,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryText,
        disabledForegroundColor: AppColors.onDisabled,
        minimumSize: minimumSize,
        textStyle: AppType.label,
        shape: shape,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      labelStyle: AppType.label.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: AppType.body.copyWith(color: AppColors.textSecondary),
      errorStyle: AppType.caption.copyWith(color: AppColors.error),
      border: outline(AppColors.outline),
      enabledBorder: outline(AppColors.outline),
      focusedBorder: outline(AppColors.primary, width: 2),
      errorBorder: outline(AppColors.error),
      focusedErrorBorder: outline(AppColors.error, width: 2),
      disabledBorder: outline(AppColors.disabled),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: shape,
    ),
  );
}
