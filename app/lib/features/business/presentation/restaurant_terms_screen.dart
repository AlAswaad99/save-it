import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/errors/app_exception.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_card.dart';
import 'package:save_it/features/business/data/restaurant_terms.dart';
import 'package:save_it/l10n/context_l10n.dart';

/// The restaurant terms page stays empty until Arise sends the document.
class RestaurantTermsScreen extends ConsumerStatefulWidget {
  const RestaurantTermsScreen({super.key});

  @override
  ConsumerState<RestaurantTermsScreen> createState() =>
      _RestaurantTermsScreenState();
}

class _RestaurantTermsScreenState extends ConsumerState<RestaurantTermsScreen> {
  var _accepted = false;
  var _busy = false;
  String? _error;

  Future<void> _accept() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(restaurantTermsProvider).accept();
      if (!mounted) {
        return;
      }
      ref
          .read(appSessionProvider.notifier)
          .replace(
            const AppSession.restaurant(restaurantTermsAccepted: true),
          );
      context.go('/business/today');
    } on AppException {
      if (mounted) {
        setState(() => _error = context.l10n.errorSi001);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = ref.watch(_restaurantNameProvider);
    return Scaffold(
      key: const Key('business-terms'),
      appBar: AppBar(title: Text(l10n.termsTitle)),
      body: name.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(l10n.errorSi001)),
        data: (restaurant) => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.businessModeBadge),
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.termsIntro(restaurant)),
              const SizedBox(height: AppSpacing.md),
              SaveItCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.termsDocTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.termsPending),
                  ],
                ),
              ),
              const Spacer(),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _accepted,
                onChanged: (value) =>
                    setState(() => _accepted = value ?? false),
                title: Text(l10n.termsAccept(restaurant)),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (_error != null) Text(_error!),
              SaveItButton(
                label: l10n.actionAcceptAndContinue,
                isLoading: _busy,
                onPressed: _accepted && !_busy ? _accept : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _restaurantNameProvider = FutureProvider<String>(
  (ref) => ref.watch(restaurantTermsProvider).restaurantName(),
);
