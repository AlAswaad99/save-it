import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'env.g.dart';

/// Values from `--dart-define-from-file=env/{dev,prod}.json`.
class Env {
  const Env({
    required this.flavor,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  final String flavor;
  final String supabaseUrl;
  final String supabaseAnonKey;

  bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  bool get isDev => flavor == 'dev';

  static const Env fromDefines = Env(
    flavor: String.fromEnvironment('FLAVOR', defaultValue: 'dev'),
    supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
  );
}

@Riverpod(keepAlive: true)
Env env(Ref ref) => Env.fromDefines;
