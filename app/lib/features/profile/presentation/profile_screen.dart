import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_card.dart';
import 'package:save_it/features/auth/presentation/sign_in_gate.dart';
import 'package:save_it/features/profile/data/account_directory.dart';
import 'package:save_it/features/profile/data/external_links.dart';
import 'package:save_it/features/profile/domain/account_profile.dart';
import 'package:save_it/l10n/context_l10n.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isDev = ref.watch(envProvider).isDev;
    final guest = ref.watch(appSessionProvider).role == AppRole.guest;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabProfile)),
      body: Column(
        children: [
          Expanded(
            child: guest ? const _GuestProfile() : const _SignedInProfile(),
          ),
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

class _GuestProfile extends StatelessWidget {
  const _GuestProfile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.guestTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.guestBody),
          const SizedBox(height: AppSpacing.lg),
          SaveItButton(
            label: l10n.actionContinueWithEmail,
            onPressed: () => unawaited(
              SignInGate.show(context, returnTo: '/profile'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignedInProfile extends ConsumerWidget {
  const _SignedInProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final account = ref.watch(accountProfileProvider);
    return account.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _SignedInFrame(
        child: Text(l10n.errorSi001),
      ),
      data: (profile) => _SignedInFrame(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _IdentityCard(profile: profile),
            const SizedBox(height: AppSpacing.md),
            SaveItCard(
              child: Column(
                children: [
                  _LinkRow(
                    icon: Icons.description_outlined,
                    label: l10n.termsLink,
                    onTap: () => context.push('/legal/terms'),
                  ),
                  const Divider(height: 1),
                  _LinkRow(
                    icon: Icons.lock_outline,
                    label: l10n.privacyLink,
                    onTap: () => context.push('/legal/privacy'),
                  ),
                  const Divider(height: 1),
                  _LinkRow(
                    icon: Icons.mail_outline,
                    label: l10n.support,
                    detail: profile.supportEmail,
                    onTap: () => unawaited(
                      ref
                          .read(externalLinksProvider)
                          .openMail(profile.supportEmail),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignedInFrame extends ConsumerWidget {
  const _SignedInFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Column(
      children: [
        Expanded(child: child),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SaveItButton(
            key: const Key('log-out'),
            label: l10n.actionLogOut,
            variant: SaveItButtonVariant.secondary,
            onPressed: () {
              unawaited(_logOut(context, ref));
            },
          ),
        ),
      ],
    );
  }

  Future<void> _logOut(BuildContext context, WidgetRef ref) async {
    await ref.read(appSessionProvider.notifier).signOut();
    if (context.mounted) {
      context.go('/explore');
    }
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.profile});

  final AccountProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SaveItCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.onSuccess,
            foregroundColor: AppColors.primaryText,
            child: Text(initials(profile.fullName)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  profile.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  formatPhone(profile.phone),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SaveItButton(
            label: l10n.actionEdit,
            variant: SaveItButtonVariant.text,
            onPressed: () => context.push('/profile/edit'),
          ),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.detail,
  });

  final IconData icon;
  final String label;
  final String? detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label),
                  if (detail != null && detail!.isNotEmpty)
                    Text(
                      detail!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
