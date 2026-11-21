import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';
import 'package:save_it/l10n/context_l10n.dart';

class SaveItOfflineBanner extends StatelessWidget {
  const SaveItOfflineBanner({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = message ?? context.l10n.offlineBanner;
    return Semantics(
      container: true,
      liveRegion: true,
      child: ColoredBox(
        color: AppColors.onWarning,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              const ExcludeSemantics(
                child: Icon(Icons.cloud_off_outlined, color: AppColors.warning),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  text,
                  style: AppType.body.copyWith(color: AppColors.warning),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
