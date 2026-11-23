import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/models/core_models.dart';
import 'package:save_it/core/theme/app_spacing.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_error_state.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/location/data/areas_repository.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/l10n/context_l10n.dart';

class AreaScreen extends ConsumerStatefulWidget {
  const AreaScreen({super.key});

  static const screenKey = Key('area');

  @override
  ConsumerState<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends ConsumerState<AreaScreen> {
  var _query = '';
  int? _selectedId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final areas = ref.watch(areasProvider);
    return Scaffold(
      key: AreaScreen.screenKey,
      appBar: AppBar(title: Text(l10n.chooseAreaTitle)),
      body: areas.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => SaveItErrorState(
          title: l10n.galleryErrorTitle,
          message: l10n.areasLoadError,
          onRetry: () => ref.invalidate(areasProvider),
        ),
        data: (items) {
          final filtered = [
            for (final area in items)
              if (area.name.toLowerCase().contains(_query.trim().toLowerCase()))
                area,
          ];
          final selected = _selected(items);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SaveItTextField(
                  label: l10n.searchAreasHint,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(l10n.areasHeader),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final area in filtered)
                      ListTile(
                        title: Text(area.name),
                        selected: area.id == _selectedId,
                        onTap: () => setState(() => _selectedId = area.id),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SaveItButton(
                  label: l10n.actionShowRestaurants,
                  onPressed: selected == null
                      ? null
                      : () => unawaited(_save(selected)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Area? _selected(List<Area> items) {
    for (final area in items) {
      if (area.id == _selectedId) {
        return area;
      }
    }
    return null;
  }

  Future<void> _save(Area area) async {
    await ref
        .read(searchOriginProvider.notifier)
        .save(
          SearchOrigin(
            latitude: area.location.latitude,
            longitude: area.location.longitude,
            isGps: false,
            fixedAt: ref.read(clockProvider)().toUtc(),
            areaId: area.id,
            areaName: area.name,
          ),
        );
    if (!mounted) {
      return;
    }
    context.go('/explore');
  }
}
