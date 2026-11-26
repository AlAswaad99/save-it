import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/theme/app_colors.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/l10n/context_l10n.dart';

class WalkthroughSlide {
  const WalkthroughSlide({
    required this.assetPath,
    required this.title,
    required this.body,
  });

  final String assetPath;
  final String title;
  final String body;
}

/// C-29. Three slides, once per install. Skip or Get started opens the location sheet.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  static const screenKey = Key('welcome');

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _page = PageController();
  var _index = 0;

  List<WalkthroughSlide> _slides() {
    final l10n = context.l10n;
    return [
      WalkthroughSlide(
        assetPath: 'assets/onboarding/Cycle.png',
        title: l10n.walkthrough1Title,
        body: l10n.walkthrough1Body,
      ),
      WalkthroughSlide(
        assetPath: 'assets/onboarding/La point.png',
        title: l10n.walkthrough2Title,
        body: l10n.walkthrough2Body,
      ),
      WalkthroughSlide(
        assetPath: 'assets/onboarding/La pay.png',
        title: l10n.walkthrough3Title,
        body: l10n.walkthrough3Body,
      ),
    ];
  }

  Future<void> _finish() async {
    await ref.read(walkthroughSeenProvider.notifier).markSeen();
    if (!mounted) {
      return;
    }
    context.go('/explore');
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final slides = _slides();
    final last = _index == slides.length - 1;
    return Scaffold(
      key: WelcomeScreen.screenKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SaveItButton(
                  label: l10n.actionSkip,
                  variant: SaveItButtonVariant.text,
                  onPressed: () => unawaited(_finish()),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _page,
                  itemCount: slides.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return ListView(
                      children: [
                        Semantics(
                          label: slide.title,
                          image: true,
                          child: ExcludeSemantics(
                            child: Image.asset(
                              slide.assetPath,
                              height: 240,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          slide.body,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < slides.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxs,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: i == _index
                              ? AppColors.accent
                              : AppColors.disabled,
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox(width: 8, height: 8),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SaveItButton(
                label: last ? l10n.actionGetStarted : l10n.actionNext,
                onPressed: () {
                  if (last) {
                    unawaited(_finish());
                    return;
                  }
                  _page.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
