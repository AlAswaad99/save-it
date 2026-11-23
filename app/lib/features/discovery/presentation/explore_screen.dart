import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/features/location/presentation/location_prompt.dart';
import 'package:save_it/features/location/presentation/location_sheet.dart';
import 'package:save_it/l10n/context_l10n.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openSheetIfNeeded());
  }

  void _openSheetIfNeeded() {
    if (!mounted || !ref.read(locationPromptProvider)) {
      return;
    }
    ref.read(locationPromptProvider.notifier).clear();
    LocationSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen(locationPromptProvider, (previous, next) {
      if (next) {
        _openSheetIfNeeded();
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabExplore)),
      body: PlaceholderBody(message: l10n.explorePlaceholder),
    );
  }
}
