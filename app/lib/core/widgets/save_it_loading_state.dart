import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/l10n/context_l10n.dart';

class SaveItLoadingState extends StatelessWidget {
  const SaveItLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.loadingLabel,
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SkeletonBar(width: 180),
            SizedBox(height: AppSpacing.sm),
            _SkeletonBar(width: double.infinity),
            SizedBox(height: AppSpacing.xs),
            _SkeletonBar(width: 240),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.skeleton,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
    );
  }
}
