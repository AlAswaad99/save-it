import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/l10n/context_l10n.dart';

/// C-12. Shown over the place the guest tried to continue from.
class SignInGate extends StatelessWidget {
  const SignInGate({required this.returnTo, super.key});

  final String returnTo;

  static Future<void> show(BuildContext context, {required String returnTo}) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SignInGate(returnTo: returnTo),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.signUpGateTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.signUpGateBody,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          SaveItButton(
            label: l10n.actionContinueWithEmail,
            onPressed: () {
              Navigator.of(context).pop();
              context.push(
                '/auth/email?from=${Uri.encodeQueryComponent(returnTo)}',
              );
            },
          ),
        ],
      ),
    );
  }
}
