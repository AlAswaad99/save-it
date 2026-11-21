import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';

/// Titillium Web, regular (400), semibold (600) and bold (700) only.
///
/// [TextStyle.height] is a multiplier of the font size.
abstract final class AppType {
  static const String family = 'Titillium Web';

  static const TextStyle display = TextStyle(
    fontFamily: family,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title = TextStyle(
    fontFamily: family,
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: family,
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontFamily: family,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle label = TextStyle(
    fontFamily: family,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: family,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}
