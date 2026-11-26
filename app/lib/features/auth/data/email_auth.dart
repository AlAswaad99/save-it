import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';
import 'package:save_it/features/auth/data/session_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthFailureKind { wrongOrExpired, rateLimited }

class AuthFailure implements Exception {
  const AuthFailure(this.kind, {this.retryAfterMinutes});

  final AuthFailureKind kind;
  final int? retryAfterMinutes;
}

class VerifiedEmail {
  const VerifiedEmail({
    required this.role,
    required this.profileComplete,
    required this.email,
    this.restaurantTermsAccepted = false,
  });

  final AppRole role;
  final bool profileComplete;
  final bool restaurantTermsAccepted;
  final String email;
}

abstract class EmailAuth {
  Future<void> sendCode(String email);

  Future<VerifiedEmail> verifyCode({required String email, required String code});
}

class SupabaseEmailAuth implements EmailAuth {
  SupabaseEmailAuth(this._ref);

  final Ref _ref;

  @override
  Future<void> sendCode(String email) async {
    final client = _client();
    try {
      await client.auth.signInWithOtp(email: email);
    } on AuthException catch (error) {
      throw _failure(error.message);
    }
  }

  @override
  Future<VerifiedEmail> verifyCode({
    required String email,
    required String code,
  }) async {
    final client = _client();
    try {
      await client.auth.verifyOTP(
        email: email,
        token: code,
        type: OtpType.email,
      );
    } on AuthException catch (error) {
      throw _failure(error.message);
    }
    final user = client.auth.currentUser;
    if (user == null) {
      throw const AuthFailure(AuthFailureKind.wrongOrExpired);
    }
    final session = await loadAppSession(client);
    return VerifiedEmail(
      role: session.role == AppRole.guest ? AppRole.customer : session.role,
      profileComplete: session.profileComplete,
      restaurantTermsAccepted: session.restaurantTermsAccepted,
      email: user.email ?? email,
    );
  }

  SupabaseClient _client() {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase is not configured');
    }
    return client;
  }

  AuthFailure _failure(String message) {
    if (message.contains('SI050')) {
      return const AuthFailure(
        AuthFailureKind.rateLimited,
        retryAfterMinutes: 60,
      );
    }
    return const AuthFailure(AuthFailureKind.wrongOrExpired);
  }
}

class FakeEmailAuth implements EmailAuth {
  FakeEmailAuth({
    this.profileComplete = false,
    this.restaurantTermsAccepted = false,
    this.role = AppRole.customer,
    this.verifyFailure,
    this.sendFailure,
  });

  bool profileComplete;
  bool restaurantTermsAccepted;
  AppRole role;
  AuthFailure? verifyFailure;
  AuthFailure? sendFailure;
  var sends = 0;
  String? lastEmail;

  @override
  Future<void> sendCode(String email) async {
    sends += 1;
    lastEmail = email;
    final failure = sendFailure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<VerifiedEmail> verifyCode({
    required String email,
    required String code,
  }) async {
    final failure = verifyFailure;
    if (failure != null) {
      throw failure;
    }
    return VerifiedEmail(
      role: role,
      profileComplete: profileComplete,
      restaurantTermsAccepted: restaurantTermsAccepted,
      email: email,
    );
  }
}

final emailAuthProvider = Provider<EmailAuth>(SupabaseEmailAuth.new);

class PendingSignInEmail extends Notifier<String> {
  @override
  String build() => '';

  void setEmail(String email) => state = email;
}

final pendingSignInEmailProvider =
    NotifierProvider<PendingSignInEmail, String>(PendingSignInEmail.new);

String maskEmail(String email) {
  final at = email.indexOf('@');
  if (at <= 1) {
    return email;
  }
  return '${email.substring(0, 1)}***${email.substring(at)}';
}
