import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:save_it/core/models/json_converters.dart';

/// GPS for the location sheet. Tests substitute a fake.
abstract class DeviceLocation {
  Future<bool> requestPermission();

  /// Null when no position arrives before [timeout].
  Future<GeoPoint?> currentPosition({required Duration timeout});
}

const locationTimeout = Duration(seconds: 8);

class GeolocatorDeviceLocation implements DeviceLocation {
  @override
  Future<bool> requestPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<GeoPoint?> currentPosition({required Duration timeout}) async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(timeLimit: timeout),
      );
      return GeoPoint(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } on Exception {
      return null;
    }
  }
}

class FakeDeviceLocation implements DeviceLocation {
  FakeDeviceLocation({this.granted = true, this.point});

  bool granted;
  GeoPoint? point;
  var requests = 0;

  @override
  Future<bool> requestPermission() async => granted;

  @override
  Future<GeoPoint?> currentPosition({required Duration timeout}) async {
    requests += 1;
    return point;
  }
}

final deviceLocationProvider = Provider<DeviceLocation>(
  (ref) => GeolocatorDeviceLocation(),
);
