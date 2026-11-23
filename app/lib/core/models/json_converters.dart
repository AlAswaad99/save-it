/// A point stored as PostGIS geography and returned as GeoJSON or WKT.
class GeoPoint {
  const GeoPoint({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  bool operator ==(Object other) {
    return other is GeoPoint &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude);
}

/// Reads a GeoJSON Point, `{lat, lng}`, or `POINT(lng lat)`.
GeoPoint? geoPointFromJson(Object? json) {
  if (json == null) {
    return null;
  }
  if (json is Map) {
    if (json['type'] == 'Point' && json['coordinates'] is List) {
      final coordinates = json['coordinates'] as List<dynamic>;
      if (coordinates.length >= 2 &&
          coordinates[0] is num &&
          coordinates[1] is num) {
        return GeoPoint(
          latitude: (coordinates[1] as num).toDouble(),
          longitude: (coordinates[0] as num).toDouble(),
        );
      }
    }
    final lat = json['lat'] ?? json['latitude'];
    final lng = json['lng'] ?? json['longitude'];
    if (lat is num && lng is num) {
      return GeoPoint(latitude: lat.toDouble(), longitude: lng.toDouble());
    }
  }
  if (json is String) {
    final match = RegExp(
      r'POINT\s*\(\s*(-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)\s*\)',
      caseSensitive: false,
    ).firstMatch(json);
    if (match != null) {
      return GeoPoint(
        longitude: double.parse(match.group(1)!),
        latitude: double.parse(match.group(2)!),
      );
    }
  }
  return null;
}

Object? geoPointToJson(GeoPoint? point) {
  if (point == null) {
    return null;
  }
  return {
    'type': 'Point',
    'coordinates': [point.longitude, point.latitude],
  };
}

GeoPoint geoPointRequiredFromJson(Object? json) {
  final point = geoPointFromJson(json);
  if (point == null) {
    throw const FormatException('Expected a geographic point.');
  }
  return point;
}

Object geoPointRequiredToJson(GeoPoint point) {
  return {
    'type': 'Point',
    'coordinates': [point.longitude, point.latitude],
  };
}

/// Money and rates travel as text so a price is never a binary float.
String numericFromJson(Object? json) {
  if (json == null) {
    return '0';
  }
  return json.toString();
}

Object numericToJson(String value) => value;
