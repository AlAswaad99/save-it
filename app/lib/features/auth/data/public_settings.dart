import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';

abstract class PublicSettings {
  Future<String> supportEmail();
}

class SupabasePublicSettings implements PublicSettings {
  SupabasePublicSettings(this._ref);

  final Ref _ref;

  @override
  Future<String> supportEmail() async {
    final client = _ref.read(supabaseClientProvider);
    if (client == null) {
      throw StateError('Supabase is not configured');
    }
    final raw = await client.rpc<Object?>('public_settings');
    final settings = Map<String, dynamic>.from(raw! as Map);
    final email = settings['support_email'];
    return email is String ? email : '';
  }
}

class FixedPublicSettings implements PublicSettings {
  const FixedPublicSettings(this.email);

  final String email;

  @override
  Future<String> supportEmail() async => email;
}

final publicSettingsProvider = Provider<PublicSettings>(
  SupabasePublicSettings.new,
);

final supportEmailProvider = FutureProvider<String>(
  (ref) => ref.watch(publicSettingsProvider).supportEmail(),
);
