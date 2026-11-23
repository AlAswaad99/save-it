import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/features/auth/data/auth_events.dart';

/// Guest until a stored Supabase session is restored, or the customer signs in.
class AppSessionController extends Notifier<AppSession> {
  @override
  AppSession build() {
    final auth = ref.watch(authEventsProvider);
    final subscription = auth.changes().listen((session) {
      state = session;
    });
    ref.onDispose(subscription.cancel);
    unawaited(
      auth.restore().then((session) {
        if (session != null && ref.mounted) {
          state = session;
        }
      }),
    );
    return const AppSession.guest();
  }

  void replace(AppSession session) => state = session;

  void signedInCustomer({required bool profileComplete}) {
    state = AppSession.customer(profileComplete: profileComplete);
  }

  Future<void> signOut() async {
    await ref.read(authEventsProvider).signOut();
    state = const AppSession.guest();
  }
}

final appSessionProvider = NotifierProvider<AppSessionController, AppSession>(
  AppSessionController.new,
);
