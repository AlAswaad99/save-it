import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/features/auth/data/public_settings.dart';
import 'package:save_it/features/profile/data/external_links.dart';
import 'package:save_it/l10n/context_l10n.dart';

/// Restaurant login. Unknown emails are not created. A customer email is
/// signed out again after the code, so it never stays in Business mode.
class BusinessLoginScreen extends ConsumerStatefulWidget {
  const BusinessLoginScreen({super.key});

  @override
  ConsumerState<BusinessLoginScreen> createState() =>
      _BusinessLoginScreenState();
}

class _BusinessLoginScreenState extends ConsumerState<BusinessLoginScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  var _codeStep = false;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final email = _email.text.trim();
    if (!email.contains('@')) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(emailAuthProvider).sendCode(email, allowCreate: false);
      if (mounted) {
        setState(() => _codeStep = true);
      }
    } on AuthFailure catch (failure) {
      if (!mounted) {
        return;
      }
      final l10n = context.l10n;
      setState(() {
        _error = failure.kind == AuthFailureKind.rateLimited
            ? l10n.codeResendLimit
            : l10n.bizAccountMissing;
      });
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _verify(String code) async {
    if (_busy || code.length != 6) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final verified = await ref
          .read(emailAuthProvider)
          .verifyCode(email: _email.text.trim(), code: code);
      if (!mounted) {
        return;
      }
      if (verified.role != AppRole.restaurant) {
        await ref.read(appSessionProvider.notifier).signOut();
        if (mounted) {
          setState(() => _error = context.l10n.errorSi001);
        }
        return;
      }
      ref
          .read(appSessionProvider.notifier)
          .replace(
            AppSession.restaurant(
              restaurantTermsAccepted: verified.restaurantTermsAccepted,
            ),
          );
      if (!mounted) {
        return;
      }
      context.go(
        verified.restaurantTermsAccepted
            ? '/business/today'
            : '/business/terms',
      );
    } on AuthFailure {
      if (mounted) {
        setState(() => _error = context.l10n.codeErrorTitle);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final support = ref.watch(supportEmailProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_codeStep ? l10n.codeAppBar : l10n.bizLoginTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.businessModeBadge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _codeStep ? l10n.codeHeading : l10n.bizLoginBody,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!_codeStep)
            SaveItTextField(
              label: l10n.fieldRestaurantEmail,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              errorText: _error,
            )
          else
            SaveItTextField(
              label: l10n.codeAppBar,
              controller: _code,
              keyboardType: TextInputType.number,
              errorText: _error,
              onChanged: (value) {
                if (value.trim().length == 6) {
                  unawaited(_verify(value.trim()));
                }
              },
            ),
          const SizedBox(height: AppSpacing.md),
          if (!_codeStep)
            SaveItButton(
              label: l10n.actionSendCode,
              isLoading: _busy,
              onPressed: _busy ? null : _send,
            ),
          const SizedBox(height: AppSpacing.lg),
          support.when(
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
            data: (email) => Text.rich(
              TextSpan(
                text: l10n.bizAccountsNotePrefix,
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => unawaited(
                        ref.read(externalLinksProvider).openMail(email),
                      ),
                      child: Text(
                        email,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: l10n.bizAccountsNoteSuffix),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SaveItButton(
            label: l10n.actionBackToCustomerApp,
            variant: SaveItButtonVariant.text,
            onPressed: () => context.go('/explore'),
          ),
        ],
      ),
    );
  }
}
