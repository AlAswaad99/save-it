import 'package:flutter/widgets.dart';
import 'package:save_it/core/config/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Starts bindings and Supabase when env defines a project.
///
/// Firebase and Crashlytics are initialised in T01.6, once the Firebase
/// projects exist. Until then the app runs without them.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final env = Env.fromDefines;
  if (!env.isConfigured) {
    return;
  }
  await Supabase.initialize(
    url: env.supabaseUrl,
    publishableKey: env.supabaseAnonKey,
  );
}
