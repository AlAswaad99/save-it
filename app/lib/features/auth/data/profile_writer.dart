import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/errors/error_messages.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileWriter {
  Future<void> complete({
    required String fullName,
    required String phone,
    required bool acceptTerms,
  });
}

class SupabaseProfileWriter implements ProfileWriter {
  SupabaseProfileWriter(this._ref);

  final Ref _ref;

  @override
  Future<void> complete({
    required String fullName,
    required String phone,
    required bool acceptTerms,
  }) async {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase is not configured');
    }
    try {
      await client.rpc<void>(
        'complete_profile',
        params: {
          'full_name': fullName,
          'phone': phone,
          'accept_terms': acceptTerms,
        },
      );
    } on PostgrestException catch (error) {
      throw exceptionFromPostgrest(error);
    }
  }
}

class FakeProfileWriter implements ProfileWriter {
  String? fullName;
  String? phone;
  var accepted = false;

  @override
  Future<void> complete({
    required String fullName,
    required String phone,
    required bool acceptTerms,
  }) async {
    this.fullName = fullName;
    this.phone = phone;
    accepted = acceptTerms;
  }
}

final profileWriterProvider = Provider<ProfileWriter>(
  SupabaseProfileWriter.new,
);
