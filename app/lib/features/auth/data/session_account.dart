import 'package:save_it/core/session/app_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Reads the role and the two flags the router needs from the signed-in user.
Future<AppSession> loadAppSession(SupabaseClient client) async {
  final user = client.auth.currentUser;
  if (user == null) {
    return const AppSession.guest();
  }
  final row = await client
      .from('profiles')
      .select('role, full_name, phone, terms_accepted_at')
      .eq('id', user.id)
      .maybeSingle();
  if (row == null) {
    return const AppSession.guest();
  }
  if (row['role'] == 'restaurant') {
    final restaurant = await client
        .from('restaurants')
        .select('terms_accepted_at')
        .eq('user_id', user.id)
        .maybeSingle();
    return AppSession.restaurant(
      restaurantTermsAccepted: restaurant?['terms_accepted_at'] != null,
    );
  }
  final complete =
      row['full_name'] != null &&
      row['phone'] != null &&
      row['terms_accepted_at'] != null;
  return AppSession.customer(profileComplete: complete);
}
