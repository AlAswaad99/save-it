import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/widgets/save_it_logo.dart';

void main() {
  test('logo asset is the supplied La Logo.png', () {
    final asset = File(SaveItLogo.assetPath).readAsBytesSync();
    final source = File('../docs/businessrules-and-contents/La Logo.png')
        .readAsBytesSync();
    expect(asset, source);
  });

  test('text and fill colours meet WCAG AA', () {
    expect(
      _contrast(AppColors.onPrimary, AppColors.primary),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.onAccent, AppColors.accent),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.primaryText, AppColors.background),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.primaryText, AppColors.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.accentText, AppColors.background),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.accentText, AppColors.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.textPrimary, AppColors.background),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.textSecondary, AppColors.background),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.textSecondary, AppColors.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.success, AppColors.onSuccess),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.warning, AppColors.onWarning),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.error, AppColors.errorContainer),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.onError, AppColors.error),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.neutral, AppColors.onNeutral),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(AppColors.outline, AppColors.surface),
      greaterThanOrEqualTo(3),
    );
    expect(
      _contrast(AppColors.outline, AppColors.background),
      greaterThanOrEqualTo(3),
    );
    expect(AppColors.error, isNot(AppColors.accent));
  });
}

double _contrast(Color foreground, Color background) {
  final lighter = math.max(_luminance(foreground), _luminance(background));
  final darker = math.min(_luminance(foreground), _luminance(background));
  return (lighter + 0.05) / (darker + 0.05);
}

double _luminance(Color color) {
  double channel(double value) {
    return value <= 0.04045
        ? value / 12.92
        : math.pow((value + 0.055) / 1.055, 2.4).toDouble();
  }

  final red = channel(color.r);
  final green = channel(color.g);
  final blue = channel(color.b);
  return 0.2126 * red + 0.7152 * green + 0.0722 * blue;
}
