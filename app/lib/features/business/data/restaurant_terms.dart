import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/errors/error_messages.dart';
import 'package:save_it/core/supabase/supabase_client_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RestaurantTerms {
  Future<String> restaurantName();

  Future<void> accept();
}

class SupabaseRestaurantTerms implements RestaurantTerms {
  SupabaseRestaurantTerms(this._ref);

  final Ref _ref;

  @override
  Future<String> restaurantName() async {
    final client = _client();
    final userId = client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Not signed in');
    }
    final row = await client
        .from('restaurants')
        .select('name')
        .eq('user_id', userId)
        .single();
    return row['name'] as String? ?? '';
  }

  @override
  Future<void> accept() async {
    final client = _client();
    try {
      await client.rpc<void>('accept_restaurant_terms');
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
}

class MemoryRestaurantTerms implements RestaurantTerms {
  MemoryRestaurantTerms(this.name);

  final String name;
  var accepted = false;

  @override
  Future<void> accept() async {
    accepted = true;
  }

  @override
  Future<String> restaurantName() async => name;
}

final restaurantTermsProvider = Provider<RestaurantTerms>(
  SupabaseRestaurantTerms.new,
);
