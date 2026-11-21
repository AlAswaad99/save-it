import 'package:flutter/material.dart';

import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/theme/app_typography.dart';
import 'package:save_it/core/widgets/save_it_badge.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_card.dart';
import 'package:save_it/core/widgets/save_it_empty_state.dart';
import 'package:save_it/core/widgets/save_it_error_state.dart';
import 'package:save_it/core/widgets/save_it_loading_state.dart';
import 'package:save_it/core/widgets/save_it_logo.dart';
import 'package:save_it/core/widgets/save_it_offline_banner.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/l10n/context_l10n.dart';

/// Dev-flavor catalogue of the core widgets. Not registered in prod.
class WidgetGalleryScreen extends StatelessWidget {
  const WidgetGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.galleryTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: SaveItLogo(height: 180)),
            ),
            _Section(
              title: l10n.gallerySectionButtons,
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  SaveItButton(label: l10n.buttonPrimary, onPressed: () {}),
                  SaveItButton(
                    label: l10n.buttonSecondary,
                    variant: SaveItButtonVariant.secondary,
                    onPressed: () {},
                  ),
                  SaveItButton(
                    label: l10n.buttonText,
                    variant: SaveItButtonVariant.text,
                    onPressed: () {},
                  ),
                  SaveItButton(
                    label: l10n.buttonDestructive,
                    variant: SaveItButtonVariant.destructive,
                    onPressed: () {},
                  ),
                  SaveItButton(label: l10n.buttonDisabled, onPressed: null),
                  SaveItButton(
                    label: l10n.buttonPrimary,
                    isLoading: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            _Section(
              title: l10n.gallerySectionInputs,
              child: Column(
                children: [
                  SaveItTextField(label: l10n.fieldLabel, hint: l10n.fieldHint),
                  const SizedBox(height: AppSpacing.md),
                  SaveItTextField(
                    label: l10n.fieldLabel,
                    errorText: l10n.fieldError,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SaveItTextField(
                    label: l10n.fieldDisabledLabel,
                    enabled: false,
                  ),
                ],
              ),
            ),
            _Section(
              title: l10n.gallerySectionCard,
              child: SaveItCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.cardTitle, style: AppType.headline),
                    const SizedBox(height: AppSpacing.xs),
                    Text(l10n.cardBody, style: AppType.body),
                  ],
                ),
              ),
            ),
            _Section(
              title: l10n.gallerySectionBadges,
              child: const Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  SaveItBadge(kind: SaveItBadgeKind.reserved),
                  SaveItBadge(kind: SaveItBadgeKind.collected),
                  SaveItBadge(kind: SaveItBadgeKind.cancelled),
                  SaveItBadge(kind: SaveItBadgeKind.expired),
                  SaveItBadge(kind: SaveItBadgeKind.draft),
                  SaveItBadge(kind: SaveItBadgeKind.live),
                  SaveItBadge(kind: SaveItBadgeKind.soldOut),
                  SaveItBadge(kind: SaveItBadgeKind.hidden),
                ],
              ),
            ),
            _Section(
              title: l10n.gallerySectionStates,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SaveItEmptyState(
                    title: l10n.galleryEmptyTitle,
                    message: l10n.galleryEmptyBody,
                  ),
                  SaveItErrorState(
                    title: l10n.galleryErrorTitle,
                    message: l10n.galleryErrorBody,
                    onRetry: () {},
                  ),
                  const SaveItLoadingState(),
                ],
              ),
            ),
            const SaveItOfflineBanner(),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppType.headline),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
