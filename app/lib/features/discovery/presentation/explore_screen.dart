import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_it/core/widgets/placeholder_body.dart';
import 'package:save_it/features/location/data/device_location.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/location/presentation/location_sheet.dart';
import 'package:save_it/l10n/context_l10n.dart';

const gpsRefreshAfter = Duration(minutes: 10);

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen>
    with WidgetsBindingObserver {
  var _sheetOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybePrompt());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshGpsIfStale());
    }
  }

  Future<void> _maybePrompt() async {
    final origin = ref.read(searchOriginProvider);
    if (!origin.hasValue || origin.value != null || _sheetOpen || !mounted) {
      return;
    }
    _sheetOpen = true;
    await LocationSheet.show(context);
    _sheetOpen = false;
  }

  Future<void> _refreshGpsIfStale() async {
    final origin = ref.read(searchOriginProvider).value;
    if (origin == null || !origin.isGps) {
      return;
    }
    final age = ref.read(clockProvider)().toUtc().difference(origin.fixedAt);
    if (age < gpsRefreshAfter) {
      return;
    }
    final point = await ref
        .read(deviceLocationProvider)
        .currentPosition(timeout: locationTimeout);
    if (point == null || !mounted) {
      return;
    }
    await ref
        .read(searchOriginProvider.notifier)
        .save(
          SearchOrigin(
            latitude: point.latitude,
            longitude: point.longitude,
            isGps: true,
            fixedAt: ref.read(clockProvider)().toUtc(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final origin = ref.watch(searchOriginProvider).value;
    ref.listen(searchOriginProvider, (previous, next) {
      if (next.hasValue && next.value == null) {
        unawaited(_maybePrompt());
      }
    });
    final title = origin == null
        ? l10n.tabExplore
        : origin.isGps
        ? l10n.currentLocation
        : (origin.areaName ?? l10n.tabExplore);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          key: origin == null
              ? null
              : Key('origin-${origin.latitude}-${origin.longitude}'),
        ),
      ),
      body: PlaceholderBody(message: l10n.explorePlaceholder),
    );
  }
}
