import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/errors/error_messages.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';
import 'package:save_it/features/profile/domain/account_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AccountDirectory {
  Future<AccountProfile> load();

  Future<void> update({required String fullName, required String phone});
}

class SupabaseAccountDirectory implements AccountDirectory {
  SupabaseAccountDirectory(this._ref);

  final Ref _ref;

  @override
  Future<AccountProfile> load() async {
    final client = _client();
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('Not signed in');
    }
    final rawSettings = await client.rpc<Object?>('public_settings');
    final settings = Map<String, dynamic>.from(rawSettings! as Map);
    final row = await client
        .from('profiles')
        .select('full_name, email, phone')
        .eq('id', user.id)
        .single();
    return AccountProfile(
      fullName: row['full_name'] as String? ?? '',
      email: row['email'] as String? ?? user.email ?? '',
      phone: row['phone'] as String? ?? '',
      supportEmail: _supportEmail(settings['support_email']),
    );
  }

  @override
  Future<void> update({required String fullName, required String phone}) async {
    final client = _client();
    final user = client.auth.currentUser;
    if (user == null) {
      throw StateError('Not signed in');
    }
    try {
      await client
          .from('profiles')
          .update({'full_name': fullName, 'phone': phone})
          .eq('id', user.id);
    } on PostgrestException catch (error) {
      throw exceptionFromPostgrest(error);
    }
  }

  SupabaseClient _client() {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase is not configured');
    }
    return client;
  }

  String _supportEmail(Object? value) {
    if (value is String) {
      return value;
    }
    return '';
  }
}

class MemoryAccountDirectory implements AccountDirectory {
  MemoryAccountDirectory(this.profile);

  AccountProfile profile;
  String? savedName;
  String? savedPhone;

  @override
  Future<AccountProfile> load() async => profile;

  @override
  Future<void> update({required String fullName, required String phone}) async {
    savedName = fullName;
    savedPhone = phone;
    profile = profile.copyWith(fullName: fullName, phone: phone);
  }
}

final accountDirectoryProvider = Provider<AccountDirectory>(
  SupabaseAccountDirectory.new,
);

class AccountProfileController extends AsyncNotifier<AccountProfile> {
  @override
  Future<AccountProfile> build() => ref.watch(accountDirectoryProvider).load();

  Future<void> save({required String fullName, required String phone}) async {
    await ref
        .read(accountDirectoryProvider)
        .update(fullName: fullName, phone: phone);
    final current = await future;
    state = AsyncData(current.copyWith(fullName: fullName, phone: phone));
  }
}

final accountProfileProvider =
    AsyncNotifierProvider<AccountProfileController, AccountProfile>(
      AccountProfileController.new,
    );
