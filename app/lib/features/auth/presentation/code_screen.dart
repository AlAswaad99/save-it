import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/l10n/context_l10n.dart';

class CodeScreen extends ConsumerStatefulWidget {
  const CodeScreen({required this.email, required this.returnTo, super.key});

  final String email;
  final String returnTo;

  @override
  ConsumerState<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends ConsumerState<CodeScreen> {
  final _code = TextEditingController();
  String? _errorTitle;
  String? _errorBody;
  var _busy = false;
  var _submitted = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _verify(String code) async {
    if (_busy || code.length != 6) {
      return;
    }
    setState(() {
      _busy = true;
      _errorTitle = null;
      _errorBody = null;
    });
    try {
      final verified = await ref
          .read(emailAuthProvider)
          .verifyCode(email: widget.email, code: code);
      if (!mounted) {
        return;
      }
      ref.read(pendingSignInEmailProvider.notifier).setEmail(verified.email);
      final session = ref.read(appSessionProvider.notifier);
      if (verified.role == AppRole.restaurant) {
        session.replace(
          AppSession.restaurant(
            restaurantTermsAccepted: verified.restaurantTermsAccepted,
          ),
        );
        context.go(
          verified.restaurantTermsAccepted
              ? '/business/today'
              : '/business/terms',
        );
      } else if (verified.profileComplete) {
        session.signedInCustomer(profileComplete: true);
        context.go(widget.returnTo);
      } else {
        session.signedInCustomer(profileComplete: false);
        context.go(
          '/auth/profile?from=${Uri.encodeQueryComponent(widget.returnTo)}',
        );
      }
    } on AuthFailure catch (failure) {
      final l10n = context.l10n;
      setState(() {
        if (failure.kind == AuthFailureKind.rateLimited) {
          _errorTitle = l10n.codeResendLimit;
          _errorBody = failure.retryAfterMinutes == null
              ? l10n.errorSi050
              : l10n.codeResendWait(failure.retryAfterMinutes!);
        } else {
          _errorTitle = l10n.codeErrorTitle;
          _errorBody = l10n.codeErrorBody;
        }
        _submitted = false;
      });
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _resend() async {
    setState(() {
      _errorTitle = null;
      _errorBody = null;
    });
    try {
      await ref.read(emailAuthProvider).sendCode(widget.email);
    } on AuthFailure catch (failure) {
      if (!mounted) {
        return;
      }
      final l10n = context.l10n;
      setState(() {
        _errorTitle = l10n.codeResendLimit;
        _errorBody = failure.kind == AuthFailureKind.rateLimited
            ? l10n.codeResendWait(failure.retryAfterMinutes ?? 60)
            : l10n.codeErrorBody;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.codeAppBar)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.codeHeading, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.codeSentTo(maskEmail(widget.email))),
          const SizedBox(height: AppSpacing.lg),
          SaveItTextField(
            controller: _code,
            label: l10n.codeAppBar,
            keyboardType: TextInputType.number,
            errorText: _errorBody,
            onChanged: (value) {
              final digits = value.replaceAll(RegExp(r'\D'), '');
              if (digits != value) {
                _code.value = TextEditingValue(
                  text: digits,
                  selection: TextSelection.collapsed(offset: digits.length),
                );
              }
              if (digits.length == 6 && !_submitted) {
                _submitted = true;
                unawaited(_verify(digits));
              }
            },
          ),
          if (_errorTitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(_errorTitle!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(l10n.codeDidntGetIt),
          SaveItButton(
            label: l10n.actionResendCode,
            variant: SaveItButtonVariant.text,
            onPressed: () => unawaited(_resend()),
          ),
        ],
      ),
    );
  }
}
