import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/session/app_session.dart';

/// Guest until sign-in wires a real Supabase session.
class AppSessionController extends Notifier<AppSession> {
  @override
  AppSession build() => const AppSession.guest();

  void replace(AppSession session) => state = session;
}

final appSessionProvider = NotifierProvider<AppSessionController, AppSession>(
  AppSessionController.new,
);
