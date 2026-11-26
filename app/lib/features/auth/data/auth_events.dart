import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';
import 'package:save_it/features/auth/data/session_account.dart';

/// Supabase auth as the app session sees it.
///
/// [restore] is the session already on the device. [changes] is a later
/// sign-in, sign-out, or expiry. [signOut] deletes this account's device
/// tokens before the auth session goes away, so row-level security still
/// allows the delete.
abstract class AuthEvents {
  Future<AppSession?> restore();

  Stream<AppSession> changes();

  Future<void> signOut();
}

class IdleAuthEvents implements AuthEvents {
  const IdleAuthEvents();

  @override
  Future<AppSession?> restore() async => null;

  @override
  Stream<AppSession> changes() => const Stream.empty();

  @override
  Future<void> signOut() async {}
}

class SupabaseAuthEvents implements AuthEvents {
  SupabaseAuthEvents(this._ref);

  final Ref _ref;

  @override
  Future<AppSession?> restore() async {
    final client = _ref.read(supabaseClientProvider);
    if (client == null || client.auth.currentSession == null) {
      return null;
    }
    return loadAppSession(client);
  }

  @override
  Stream<AppSession> changes() async* {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      return;
    }
    await for (final event in client.auth.onAuthStateChange) {
      if (event.session == null) {
        yield const AppSession.guest();
        continue;
      }
      yield await loadAppSession(client);
    }
  }

  @override
  Future<void> signOut() async {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      return;
    }
    final userId = client.auth.currentUser?.id;
    if (userId != null) {
      await client.from('device_tokens').delete().eq('user_id', userId);
    }
    await client.auth.signOut();
  }
}

final authEventsProvider = Provider<AuthEvents>((ref) {
  if (ref.watch(supabaseClientProvider) == null) {
    return const IdleAuthEvents();
  }
  return SupabaseAuthEvents(ref);
});
