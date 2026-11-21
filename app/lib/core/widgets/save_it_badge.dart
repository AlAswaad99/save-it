import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';
import 'package:save_it/l10n/app_localizations.dart';
import 'package:save_it/l10n/context_l10n.dart';

enum SaveItBadgeKind {
  reserved,
  collected,
  cancelled,
  expired,
  draft,
  live,
  soldOut,
  hidden,
}

class SaveItBadge extends StatelessWidget {
  const SaveItBadge({required this.kind, super.key});

  final SaveItBadgeKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (label, foreground, background) = _style(kind, l10n);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Text(
          label,
          style: AppType.caption.copyWith(
            color: foreground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

(String, Color, Color) _style(SaveItBadgeKind kind, AppLocalizations l10n) {
  return switch (kind) {
    SaveItBadgeKind.reserved => (
      l10n.badgeReserved,
      AppColors.warning,
      AppColors.onWarning,
    ),
    SaveItBadgeKind.collected => (
      l10n.badgeCollected,
      AppColors.success,
      AppColors.onSuccess,
    ),
    SaveItBadgeKind.cancelled => (
      l10n.badgeCancelled,
      AppColors.error,
      AppColors.errorContainer,
    ),
    SaveItBadgeKind.expired => (
      l10n.badgeExpired,
      AppColors.neutral,
      AppColors.onNeutral,
    ),
    SaveItBadgeKind.draft => (
      l10n.badgeDraft,
      AppColors.neutral,
      AppColors.onNeutral,
    ),
    SaveItBadgeKind.live => (
      l10n.badgeLive,
      AppColors.success,
      AppColors.onSuccess,
    ),
    SaveItBadgeKind.soldOut => (
      l10n.badgeSoldOut,
      AppColors.warning,
      AppColors.onWarning,
    ),
    SaveItBadgeKind.hidden => (
      l10n.badgeHidden,
      AppColors.neutral,
      AppColors.onNeutral,
    ),
  };
}
