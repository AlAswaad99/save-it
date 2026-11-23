import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/router/app_redirect.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/widgets/save_it_logo.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';

/// C-01. Holds the logo, then opens the home for this session.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const screenKey = Key('splash');
  static const hold = Duration(milliseconds: 700);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  var _scheduled = false;

  void _schedule(bool walkthroughSeen) {
    if (_scheduled) {
      return;
    }
    _scheduled = true;
    unawaited(Future<void>.delayed(SplashScreen.hold, () {
      if (!mounted) {
        return;
      }
      context.go(
        homeFor(
          ref.read(appSessionProvider),
          walkthroughSeen: walkthroughSeen,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(walkthroughSeenProvider).whenData(_schedule);
    return const Scaffold(
      body: Center(
        key: SplashScreen.screenKey,
        child: SaveItLogo(),
      ),
    );
  }
}
