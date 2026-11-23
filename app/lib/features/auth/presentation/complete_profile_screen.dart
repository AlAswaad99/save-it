import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/features/auth/data/profile_writer.dart';
import 'package:save_it/l10n/context_l10n.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  var _accepted = false;
  var _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? get _e164 {
    final digits = _phone.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      return null;
    }
    final phone = '+971$digits';
    if (!RegExp(r'^\+[1-9][0-9]{6,14}$').hasMatch(phone)) {
      return null;
    }
    return phone;
  }

  Future<void> _save() async {
    final phone = _e164;
    if (phone == null) {
      setState(() => _error = context.l10n.phoneInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(profileWriterProvider)
          .complete(
            fullName: _name.text.trim(),
            phone: phone,
            acceptTerms: true,
          );
      if (!mounted) {
        return;
      }
      ref
          .read(appSessionProvider.notifier)
          .signedInCustomer(profileComplete: true);
      final from =
          GoRouterState.of(context).uri.queryParameters['from'] ?? '/explore';
      context.go(from);
    } on Exception {
      if (!mounted) {
        return;
      }
      setState(() => _error = context.l10n.errorSi051);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final email = ref.watch(pendingSignInEmailProvider);
    final ready = _name.text.trim().isNotEmpty && _e164 != null && _accepted;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileSetupAppBar)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.profileSetupHeading,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.profileSetupBody),
          const SizedBox(height: AppSpacing.md),
          Text('${l10n.fieldEmail}: $email'),
          Text(l10n.verified),
          const SizedBox(height: AppSpacing.lg),
          SaveItTextField(
            controller: _name,
            label: l10n.fieldFullName,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.md),
          SaveItTextField(
            controller: _phone,
            label: l10n.fieldPhone,
            hint: l10n.phonePrefix,
            keyboardType: TextInputType.phone,
            errorText: _error,
            onChanged: (_) => setState(() {}),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _accepted,
            onChanged: (value) => setState(() => _accepted = value ?? false),
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${l10n.termsAgreePrefix} '),
                TextButton(
                  onPressed: () => context.push('/legal/terms'),
                  child: Text(l10n.termsLink),
                ),
                Text(' ${l10n.termsAgreeJoin} '),
                TextButton(
                  onPressed: () => context.push('/legal/privacy'),
                  child: Text(l10n.privacyLink),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SaveItButton(
            label: l10n.actionContinue,
            isLoading: _busy,
            onPressed: ready ? () => unawaited(_save()) : null,
          ),
        ],
      ),
    );
  }
}
