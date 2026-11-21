import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';
import 'package:save_it/l10n/context_l10n.dart';

enum SaveItButtonVariant { primary, secondary, text, destructive }

class SaveItButton extends StatelessWidget {
  const SaveItButton({
    required this.label,
    required this.onPressed,
    this.variant = SaveItButtonVariant.primary,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final SaveItButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final canCall = onPressed != null && !isLoading;
    final callback = isLoading && onPressed != null ? () {} : onPressed;
    final spinnerColor = switch (variant) {
      SaveItButtonVariant.primary ||
      SaveItButtonVariant.destructive => AppColors.onPrimary,
      SaveItButtonVariant.secondary ||
      SaveItButtonVariant.text => AppColors.primaryText,
    };
    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: spinnerColor,
            ),
          )
        : Text(label);

    final button = switch (variant) {
      SaveItButtonVariant.primary => FilledButton(
        onPressed: callback,
        child: child,
      ),
      SaveItButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        child: child,
      ),
      SaveItButtonVariant.text => TextButton(onPressed: callback, child: child),
      SaveItButtonVariant.destructive => FilledButton(
        onPressed: callback,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.onError,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.onDisabled,
          minimumSize: const Size(
            AppSpacing.minTouchTarget,
            AppSpacing.minTouchTarget,
          ),
          textStyle: AppType.label,
        ),
        child: child,
      ),
    };

    return Semantics(
      button: true,
      enabled: canCall,
      label: isLoading ? context.l10n.buttonLoading : label,
      child: ExcludeSemantics(child: button),
    );
  }
}
