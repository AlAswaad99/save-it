import 'package:supabase_flutter/supabase_flutter.dart';

import 'rpc.dart';

/// Shared Supabase access for feature repositories.
///
/// Screens do not call Supabase. A feature repository extends this and uses
/// [rpc] for anything that changes stock, orders, or status.
abstract class BaseRepository {
  BaseRepository(this.client);

  final SupabaseClient client;

  Future<T> rpc<T>(
    String function, {
    Map<String, dynamic>? params,
    T Function(dynamic json)? decode,
  }) {
    return callRpc<T>(client, function, params: params, decode: decode);
  }
}
