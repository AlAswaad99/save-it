import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/features/location/presentation/location_flow.dart';
import 'package:save_it/l10n/app_localizations.dart';

/// C-02. The permission explainer shown over Explore.
class LocationSheet extends ConsumerWidget {
  const LocationSheet({super.key});

  static const sheetKey = Key('location-sheet');
  static const imagePath = 'assets/onboarding/image_7e411891.jpg';

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => const LocationSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      throw StateError('AppLocalizations is not installed');
    }
    return Padding(
      key: sheetKey,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            label: l10n.locationSheetTitle,
            image: true,
            child: ExcludeSemantics(
              child: Image.asset(imagePath, height: 140, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.locationSheetTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.locationSheetBody,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.lg),
          SaveItButton(
            label: l10n.actionAllowLocation,
            onPressed: () => unawaited(LocationFlow.allow(ref, context)),
          ),
          SaveItButton(
            label: l10n.actionChooseAreaInstead,
            variant: SaveItButtonVariant.text,
            onPressed: () => LocationFlow.chooseArea(context),
          ),
        ],
      ),
    );
  }
}
