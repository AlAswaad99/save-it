import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:save_it/core/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client_provider.g.dart';

/// Null until [bootstrap] has initialised Supabase from env defines.
@Riverpod(keepAlive: true)
SupabaseClient? supabaseClient(Ref ref) {
  if (!ref.watch(envProvider).isConfigured) {
    return null;
  }
  return Supabase.instance.client;
}
