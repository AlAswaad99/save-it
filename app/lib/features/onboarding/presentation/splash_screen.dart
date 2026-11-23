import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/router/app_redirect.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/widgets/save_it_logo.dart';

/// C-01. Holds the logo, then opens the home for this session.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const screenKey = Key('splash');
  static const hold = Duration(milliseconds: 700);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(SplashScreen.hold, _openHome);
    });
  }

  void _openHome() {
    if (!mounted) {
      return;
    }
    final next = homeFor(ref.read(appSessionProvider));
    context.go(next);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        key: SplashScreen.screenKey,
        child: SaveItLogo(),
      ),
    );
  }
}
