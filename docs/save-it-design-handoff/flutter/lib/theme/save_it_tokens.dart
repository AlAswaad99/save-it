import 'package:flutter/widgets.dart';

/// Spacing on a 4-point scale.
abstract final class SaveItSpace {
  static const double xxs = 4; // icon to label
  static const double xs = 8; // inside chips, badges, rows
  static const double sm = 12; // card inner gap, list gaps
  static const double md = 16; // card padding, field gaps
  static const double screen = 20; // mobile screen margin
  static const double lg = 24; // sheet and dialog padding, section gaps
  static const double xl = 32; // admin page padding
  static const double xxl = 48; // empty-state spacing
  static const double xxxl = 64; // large separations
}

/// Corner radii. Nested radii stay concentric: inner = outer - inset.
abstract final class SaveItRadius {
  static const double thumb = 8; // thumbnails in cards, code boxes
  static const double control = 12; // buttons, fields, toasts
  static const double card = 20; // cards, banners, basket bar
  static const double sheet = 28; // sheets, dialogs, tab bar top
  static const double full = 999; // chips, badges, stepper, tab pill

  static const thumbAll = BorderRadius.all(Radius.circular(thumb));
  static const controlAll = BorderRadius.all(Radius.circular(control));
  static const cardAll = BorderRadius.all(Radius.circular(card));
  static const sheetTop = BorderRadius.vertical(top: Radius.circular(sheet));
  static const sheetAll = BorderRadius.all(Radius.circular(sheet));
}

/// One shadow language: warm near-black, soft and low.
abstract final class SaveItShadows {
  /// e1 · cards
  static const e1 = <BoxShadow>[
    BoxShadow(color: Color(0x0F1C1B19), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(color: Color(0x0F1C1B19), offset: Offset(0, 4), blurRadius: 12),
  ];

  /// e2 · bars (tab bar, basket bar, sticky footers)
  static const e2 = <BoxShadow>[
    BoxShadow(color: Color(0x141C1B19), offset: Offset(0, -4), blurRadius: 16),
  ];

  /// e3 · overlays (sheets, dialogs, menus, toasts)
  static const e3 = <BoxShadow>[
    BoxShadow(color: Color(0x2E1C1B19), offset: Offset(0, 12), blurRadius: 32),
  ];

}

/// Fixed sizes from the design.
abstract final class SaveItSizes {
  static const double minTouch = 44;
  static const double buttonHeight = 52; // mobile
  static const double buttonHeightAdmin = 40;
  static const double fieldHeight = 52;
  static const double chipHeight = 36; // inside a 44 tap area
  static const double badgeHeight = 26;
  static const double basketBarHeight = 60;
  static const double tabPillWidth = 56;
  static const double tabPillHeight = 32;
  static const double scanButton = 60; // raised Business mode Scan, 4 px white ring
  static const double codeBoxWidth = 48;
  static const double codeBoxHeight = 58;
  static const double qrSize = 176;
  static const double thumb = 84; // item row photo
  static const double monogram = 44;
}
