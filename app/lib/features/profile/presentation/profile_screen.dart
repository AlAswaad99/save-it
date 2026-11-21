import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/l10n/context_l10n.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isDev = ref.watch(envProvider).isDev;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabProfile)),
      body: Column(
        children: [
          Expanded(child: PlaceholderBody(message: l10n.profilePlaceholder)),
          if (isDev)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: SaveItButton(
                label: l10n.galleryOpen,
                variant: SaveItButtonVariant.text,
                onPressed: () => context.push('/dev/gallery'),
              ),
            ),
        ],
      ),
    );
  }
}
