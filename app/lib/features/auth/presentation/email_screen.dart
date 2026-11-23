import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/l10n/context_l10n.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({required this.returnTo, super.key});

  final String returnTo;

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final _email = TextEditingController();
  String? _error;
  var _busy = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool get _valid {
    final value = _email.text.trim();
    final at = value.indexOf('@');
    return at > 0 && value.substring(at).contains('.');
  }

  Future<void> _send() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(emailAuthProvider).sendCode(_email.text.trim());
      if (!mounted) {
        return;
      }
      final from = Uri.encodeQueryComponent(widget.returnTo);
      final email = Uri.encodeQueryComponent(_email.text.trim());
      unawaited(context.push('/auth/code?from=$from&email=$email'));
    } on AuthFailure catch (failure) {
      if (!mounted) {
        return;
      }
      final l10n = context.l10n;
      setState(() {
        _error = failure.kind == AuthFailureKind.rateLimited
            ? l10n.codeResendLimit
            : l10n.fieldError;
      });
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.emailAppBar)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.emailHeading, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.emailBody),
          const SizedBox(height: AppSpacing.lg),
          SaveItTextField(
            controller: _email,
            label: l10n.fieldEmail,
            hint: l10n.fieldHint,
            errorText: _error,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.lg),
          SaveItButton(
            label: l10n.actionSendCode,
            isLoading: _busy,
            onPressed: _valid ? () => unawaited(_send()) : null,
          ),
        ],
      ),
    );
  }
}
