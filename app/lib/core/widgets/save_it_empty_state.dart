import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';

class SaveItEmptyState extends StatelessWidget {
  const SaveItEmptyState({
    required this.title,
    required this.message,
    super.key,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ExcludeSemantics(
            child: Icon(
              Icons.restaurant_outlined,
              size: 40,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: AppType.headline, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            style: AppType.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
