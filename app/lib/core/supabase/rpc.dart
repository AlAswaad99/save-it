import 'package:save_it/core/errors/app_exception.dart';
import 'package:save_it/core/errors/error_messages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Calls a Postgres function and turns an `SIxxx` failure into [AppException].
Future<T> callRpc<T>(
  SupabaseClient client,
  String function, {
  Map<String, dynamic>? params,
  T Function(dynamic json)? decode,
}) async {
  try {
    final result = await client.rpc<dynamic>(function, params: params);
    if (decode != null) {
      return decode(result);
    }
    return result as T;
  } on PostgrestException catch (error) {
    throw exceptionFromPostgrest(error);
  }
}
