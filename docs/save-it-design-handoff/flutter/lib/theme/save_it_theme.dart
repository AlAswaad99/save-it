import 'package:flutter/material.dart';

import 'save_it_colors.dart';
import 'save_it_tokens.dart';
import 'save_it_typography.dart';

export 'save_it_colors.dart';
export 'save_it_tokens.dart';
export 'save_it_typography.dart';

/// Material 3 theme for the Save It app (customer side and Business mode).
/// Use: MaterialApp(theme: SaveItTheme.light, ...)
abstract final class SaveItTheme {
  static const _scheme = ColorScheme(
    brightness: Brightness.light,
    primary: SaveItColors.primary,
    onPrimary: Colors.white,
    primaryContainer: SaveItColors.primaryContainer,
    onPrimaryContainer: SaveItColors.onPrimaryContainer,
    secondary: SaveItColors.accent,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFF6E4DE),
    onSecondaryContainer: SaveItColors.accentText,
    tertiary: SaveItColors.neutral,
    onTertiary: Colors.white,
    error: SaveItColors.error,
    onError: Colors.white,
    errorContainer: SaveItColors.errorTint,
    onErrorContainer: SaveItColors.error,
    surface: SaveItColors.surface,
    onSurface: SaveItColors.textPrimary,
    onSurfaceVariant: SaveItColors.textSecondary,
    surfaceContainerLowest: SaveItColors.surface,
    surfaceContainerLow: SaveItColors.background,
    surfaceContainer: SaveItColors.background,
    surfaceContainerHigh: SaveItColors.surfaceMuted,
    surfaceContainerHighest: SaveItColors.surfaceMuted,
    outline: SaveItColors.outlineStrong,
    outlineVariant: SaveItColors.outline,
    shadow: SaveItColors.textPrimary,
    scrim: SaveItColors.textPrimary,
    inverseSurface: SaveItColors.dark,
    onInverseSurface: Colors.white,
    inversePrimary: SaveItColors.businessBadge,
  );

  static ThemeData get light {
    final text = SaveItType.textTheme();
    const controlShape = RoundedRectangleBorder(borderRadius: SaveItRadius.controlAll);

    return ThemeData(
      useMaterial3: true,
      colorScheme: _scheme,
      fontFamily: SaveItType.family,
      textTheme: text,
      scaffoldBackgroundColor: SaveItColors.background,
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,

      appBarTheme: AppBarTheme(
        backgroundColor: SaveItColors.background,
        foregroundColor: SaveItColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: SaveItType.appBar,
        toolbarHeight: 56,
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(64, SaveItSizes.buttonHeight)),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24)),
          shape: const WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(SaveItType.label),
          backgroundColor: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.disabled) ? SaveItColors.surfaceMuted : SaveItColors.primary),
          foregroundColor: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.disabled) ? SaveItColors.outlineStrong : Colors.white),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(64, SaveItSizes.buttonHeight)),
          padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24)),
          shape: const WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(SaveItType.label),
          backgroundColor: const WidgetStatePropertyAll(SaveItColors.surface),
          foregroundColor: const WidgetStatePropertyAll(SaveItColors.primaryText),
          side: const WidgetStatePropertyAll(BorderSide(color: SaveItColors.primary, width: 1.5)),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(SaveItSizes.minTouch, SaveItSizes.minTouch)),
          shape: const WidgetStatePropertyAll(controlShape),
          textStyle: WidgetStatePropertyAll(SaveItType.label),
          foregroundColor: const WidgetStatePropertyAll(SaveItColors.primaryText),
        ),
      ),

      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(SaveItSizes.minTouch, SaveItSizes.minTouch)),
          foregroundColor: WidgetStatePropertyAll(SaveItColors.textPrimary),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SaveItColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: SaveItType.labelSmall,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: SaveItType.body.copyWith(color: SaveItColors.textSecondary),
        helperStyle: SaveItType.caption.copyWith(color: SaveItColors.textSecondary),
        errorStyle: SaveItType.labelSmall.copyWith(color: SaveItColors.error),
        border: _field(SaveItColors.outlineStrong, 1.5),
        enabledBorder: _field(SaveItColors.outlineStrong, 1.5),
        focusedBorder: _field(SaveItColors.primary, 2),
        errorBorder: _field(SaveItColors.error, 2),
        focusedErrorBorder: _field(SaveItColors.error, 2),
        disabledBorder: _field(SaveItColors.outline, 1.5),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: SaveItColors.surface,
        selectedColor: SaveItColors.primary,
        disabledColor: SaveItColors.surfaceMuted,
        checkmarkColor: Colors.white,
        labelStyle: SaveItType.labelSmall,
        secondaryLabelStyle: SaveItType.labelSmall.copyWith(color: Colors.white),
        side: const BorderSide(color: SaveItColors.outlineStrong),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        showCheckmark: true,
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: const BorderSide(color: SaveItColors.outlineStrong, width: 2),
        fillColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? SaveItColors.primary : SaveItColors.surface),
        checkColor: const WidgetStatePropertyAll(Colors.white),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? SaveItColors.primary : SaveItColors.outlineStrong),
      ),

      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? SaveItColors.primary : SaveItColors.handle),
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: SaveItColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72,
        indicatorColor: SaveItColors.primaryContainer,
        indicatorShape: const StadiumBorder(),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected)
            ? SaveItType.tab.copyWith(color: SaveItColors.primaryText, fontWeight: FontWeight.w700)
            : SaveItType.tab.copyWith(color: SaveItColors.textSecondary)),
        iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
            size: 24,
            color: s.contains(WidgetState.selected) ? SaveItColors.onPrimaryContainer : SaveItColors.textSecondary)),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SaveItColors.surface,
        surfaceTintColor: Colors.transparent,
        modalBarrierColor: SaveItColors.scrim,
        shape: RoundedRectangleBorder(borderRadius: SaveItRadius.sheetTop),
        showDragHandle: true,
        dragHandleColor: SaveItColors.handle,
        dragHandleSize: Size(36, 4),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: SaveItColors.surface,
        surfaceTintColor: Colors.transparent,
        barrierColor: SaveItColors.scrim,
        shape: const RoundedRectangleBorder(borderRadius: SaveItRadius.sheetAll),
        titleTextStyle: SaveItType.sheetTitle,
        contentTextStyle: SaveItType.bodySmall,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),

      cardTheme: const CardThemeData(
        color: SaveItColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: SaveItRadius.cardAll),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: SaveItColors.dark,
        contentTextStyle: SaveItType.bodySmall.copyWith(color: Colors.white),
        actionTextColor: SaveItColors.businessBadge,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: SaveItRadius.controlAll),
      ),

      dividerTheme: const DividerThemeData(color: SaveItColors.surfaceMuted, thickness: 1, space: 1),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: SaveItColors.primary),
      listTileTheme: ListTileThemeData(
        minVerticalPadding: 12,
        titleTextStyle: SaveItType.body,
        subtitleTextStyle: SaveItType.bodySmall.copyWith(color: SaveItColors.textSecondary),
        iconColor: SaveItColors.textPrimary,
      ),
    );
  }

  /// Business mode: same theme; screens add the dark header (see BusinessHeader).
  static ThemeData get business => light;

  static OutlineInputBorder _field(Color c, double w) => OutlineInputBorder(
        borderRadius: SaveItRadius.controlAll,
        borderSide: BorderSide(color: c, width: w),
      );
}
