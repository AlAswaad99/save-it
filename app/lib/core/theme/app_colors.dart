import 'package:flutter/material.dart';

/// Brand tokens from `docs/design/ui-design-prompt.md`.
///
/// Fills keep the brand hexes: white text on `#5B7B3A` and `#B5543A` meets
/// WCAG AA. Those same hexes are just under 4.5:1 as text on `#F7F3EC`, so
/// [primaryText] and [accentText] are one step darker for text and icons.
abstract final class AppColors {
  static const Color primary = Color(0xFF5B7B3A);
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Primary used as text or an icon on [background] or [surface].
  static const Color primaryText = Color(0xFF587738);

  static const Color accent = Color(0xFFB5543A);
  static const Color onAccent = Color(0xFFFFFFFF);

  /// Accent used as text or an icon on [background] or [surface].
  static const Color accentText = Color(0xFFB15239);

  static const Color background = Color(0xFFF7F3EC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C1B19);
  static const Color textSecondary = Color(0xFF6B635C);
  static const Color outline = Color(0xFF8F867B);

  static const Color success = Color(0xFF2C4A1E);
  static const Color onSuccess = Color(0xFFE4EFD8);
  static const Color warning = Color(0xFF6B4A08);
  static const Color onWarning = Color(0xFFF8E7C4);

  /// Error red, distinct from [accent].
  static const Color error = Color(0xFF8E1E24);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFF8E0DE);

  static const Color neutral = Color(0xFF4E4943);
  static const Color onNeutral = Color(0xFFE7E2DA);

  static const Color disabled = Color(0xFFE4DED4);
  static const Color onDisabled = Color(0xFF8A837A);
  static const Color skeleton = Color(0xFFE7E1D6);
}
