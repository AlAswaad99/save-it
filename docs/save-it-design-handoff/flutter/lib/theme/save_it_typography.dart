import 'package:flutter/material.dart';

import 'save_it_colors.dart';

/// Titillium Web, weights 400 / 600 / 700 only. Sizes are logical pixels and
/// scale with the phone's text-size setting (screens are checked at 130%).
abstract final class SaveItType {
  static const family = 'TitilliumWeb';

  static TextStyle _s(double size, double height, FontWeight w, {double spacing = 0, Color? color}) => TextStyle(
        fontFamily: family,
        fontSize: size,
        height: height / size,
        fontWeight: w,
        letterSpacing: spacing,
        color: color ?? SaveItColors.textPrimary,
      );

  /// Display 34/40 Bold. Walkthrough titles at large sizes.
  static final display = _s(34, 40, FontWeight.w700);

  /// Screen title 28/34 Bold ("Orders", "Profile", "Check your email.").
  static final screenTitle = _s(28, 34, FontWeight.w700);

  /// Title 26/32 Bold (restaurant name on C-08, Business page titles).
  static final title = _s(26, 32, FontWeight.w700);

  /// Sheet and dialog title 22/28 Bold.
  static final sheetTitle = _s(22, 28, FontWeight.w700);

  /// Headline 20/26 Semibold.
  static final headline = _s(20, 26, FontWeight.w600);

  /// App bar title 18/24 Semibold.
  static final appBar = _s(18, 24, FontWeight.w600);

  /// Body 16/24 Regular.
  static final body = _s(16, 24, FontWeight.w400);

  /// Body small 14/20 Regular.
  static final bodySmall = _s(14, 20, FontWeight.w400);

  /// Label 16/20 Semibold (buttons).
  static final label = _s(16, 20, FontWeight.w600);

  /// Label small 14/20 Semibold (chips, field labels).
  static final labelSmall = _s(14, 20, FontWeight.w600);

  /// Tab label 12/16 Semibold (active: Bold, primaryText).
  static final tab = _s(12, 16, FontWeight.w600);

  /// Caption 12/16 Regular.
  static final caption = _s(12, 16, FontWeight.w400);

  /// Badge / overline 12/16 Bold, +6% tracking, upper case (apply toUpperCase()).
  static final badge = _s(12, 16, FontWeight.w700, spacing: 0.72);

  /// Pickup code 32/40 Bold, +18% tracking, tabular figures.
  static final code = _s(32, 40, FontWeight.w700, spacing: 5.76)
      .copyWith(fontFeatures: const [FontFeature.tabularFigures()]);

  /// Pickup code on the pass (C-19) 40/48; 44/52 in emails.
  static final passCode = _s(40, 48, FontWeight.w700, spacing: 7.2)
      .copyWith(fontFeatures: const [FontFeature.tabularFigures()]);

  /// Prices: discounted (accent text) and original (struck through, secondary).
  static final priceDiscounted = _s(18, 24, FontWeight.w700, color: SaveItColors.accentText);
  static final priceOriginal = _s(14, 20, FontWeight.w400, color: SaveItColors.textSecondary)
      .copyWith(decoration: TextDecoration.lineThrough);

  /// Material text theme mapping.
  static TextTheme textTheme() => TextTheme(
        displaySmall: display,
        headlineMedium: screenTitle,
        headlineSmall: title,
        titleLarge: sheetTitle,
        titleMedium: headline,
        titleSmall: appBar,
        bodyLarge: body,
        bodyMedium: bodySmall,
        bodySmall: caption.copyWith(color: SaveItColors.textSecondary),
        labelLarge: label,
        labelMedium: labelSmall,
        labelSmall: badge,
      );
}
