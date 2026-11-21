import 'package:flutter/material.dart';

/// Save It colour tokens. Every text pair passes WCAG AA (see README).
abstract final class SaveItColors {
  // Brand
  /// Fills: primary buttons, selected chips, Scan button, basket bar. White text on it (4.84:1).
  static const primary = Color(0xFF5B7B3A);

  /// Vine as text or icon: links, active tab label (4.62:1 on background).
  static const primaryText = Color(0xFF587738);

  /// Active tab pill, info notes, verified field, no-photo defaults.
  static const primaryContainer = Color(0xFFE9EFE1);

  /// Text and icons on [primaryContainer] (5.14:1).
  static const onPrimaryContainer = Color(0xFF4F6B32);

  /// Terracotta. Only for the discount badge fill, "New" dots, walkthrough highlights and the logo.
  static const accent = Color(0xFFB5543A);

  /// Discounted price as text (4.59:1 on background).
  static const accentText = Color(0xFFB15239);

  // Neutrals
  static const background = Color(0xFFF7F3EC);
  static const surface = Color(0xFFFFFFFF);

  /// Skeletons, segmented track, disabled fills.
  static const surfaceMuted = Color(0xFFEFEAE1);

  /// Dividers and card hairlines (decorative only).
  static const outline = Color(0xFFE2DBD0);

  /// Input, checkbox and chip borders (3.68:1 on white).
  static const outlineStrong = Color(0xFF8C847B);

  static const textPrimary = Color(0xFF1C1B19);
  static const textSecondary = Color(0xFF6B635C);

  /// Sheet drag handle.
  static const handle = Color(0xFFC9C2B8);

  // Status: tint (background), text/solid
  static const successTint = Color(0xFFE4F0E2);
  static const success = Color(0xFF2E6B3A);
  static const warningTint = Color(0xFFFCEFD2);
  static const warning = Color(0xFF7A5200);
  static const errorTint = Color(0xFFFBE7EA);

  /// Raspberry red, kept apart from terracotta so a price never reads as an error.
  static const error = Color(0xFFB4233C);
  static const neutralTint = Color(0xFFECE9E4);
  static const neutral = Color(0xFF55504A);

  // Business mode and dark surfaces
  /// Business mode header, toasts, lock-screen previews.
  static const dark = Color(0xFF2B2926);

  /// BUSINESS MODE badge on the dark header, toast action text (9.88:1 on [dark]).
  static const businessBadge = Color(0xFFC6DDA8);

  /// Modal scrim: textPrimary at 48%.
  static const scrim = Color(0x7A1C1B19);
}
