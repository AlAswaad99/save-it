import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/bootstrap.dart';
import 'package:save_it/core/router/app_router.dart';
import 'package:save_it/core/theme/app_theme.dart';
import 'package:save_it/l10n/app_localizations.dart';
import 'package:save_it/l10n/context_l10n.dart';

Future<void> main() async {
  await bootstrap();
  runApp(const ProviderScope(child: SaveItApp()));
}

class SaveItApp extends ConsumerWidget {
  const SaveItApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      routerConfig: router,
      theme: buildAppTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
