import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/features/location/data/device_location.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';

/// C-02. Allow location, or leave the sheet for the area picker.
class LocationFlow {
  static Future<void> allow(WidgetRef ref, BuildContext context) async {
    final granted = await ref.read(deviceLocationProvider).requestPermission();
    if (!context.mounted) {
      return;
    }
    if (!granted) {
      _openAreaPicker(context);
      return;
    }
    final point = await ref
        .read(deviceLocationProvider)
        .currentPosition(timeout: locationTimeout);
    if (!context.mounted) {
      return;
    }
    if (point == null) {
      _openAreaPicker(context);
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
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  static void chooseArea(BuildContext context) => _openAreaPicker(context);

  static void _openAreaPicker(BuildContext context) {
    Navigator.of(context).pop();
    context.push('/area');
  }
}
