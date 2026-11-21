import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/firebase_options_dev.dart' as firebase_dev;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Starts bindings, Firebase for the dev flavor, and Supabase when env defines a project.
///
/// Prod has no Firebase app yet. `firebase_options_prod.dart` is added when
/// `flutterfire configure` is run for the prod project.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final env = Env.fromDefines;
  if (env.isDev) {
    await Firebase.initializeApp(
      options: firebase_dev.DefaultFirebaseOptions.currentPlatform,
    );
  }
  if (!env.isConfigured) {
    return;
  }
  await Supabase.initialize(
    url: env.supabaseUrl,
    publishableKey: env.supabaseAnonKey,
  );
}
