import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/features/auth/presentation/sign_in_gate.dart';
import 'package:save_it/l10n/context_l10n.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final guest = ref.watch(appSessionProvider).role == AppRole.guest;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabOrders)),
      body: guest
          ? Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.guestOrdersTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.guestOrdersBody),
                  const SizedBox(height: AppSpacing.lg),
                  SaveItButton(
                    label: l10n.actionContinueWithEmail,
                    onPressed: () => unawaited(
                      SignInGate.show(context, returnTo: '/orders'),
                    ),
                  ),
                ],
              ),
            )
          : PlaceholderBody(message: l10n.ordersPlaceholder),
    );
  }
}
