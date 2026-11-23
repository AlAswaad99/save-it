class SearchOrigin {
  const SearchOrigin({
    required this.latitude,
    required this.longitude,
    required this.isGps,
    required this.fixedAt,
    this.areaId,
    this.areaName,
  });

  final double latitude;
  final double longitude;
  final bool isGps;
  final DateTime fixedAt;
  final int? areaId;
  final String? areaName;

  Map<String, Object?> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'is_gps': isGps,
      'fixed_at': fixedAt.toUtc().toIso8601String(),
      'area_id': areaId,
      'area_name': areaName,
    };
  }

  static SearchOrigin? fromJson(Map<String, Object?> json) {
    final latitude = json['latitude'];
    final longitude = json['longitude'];
    final fixedAt = json['fixed_at'];
    if (latitude is! num || longitude is! num || fixedAt is! String) {
      return null;
    }
    final parsed = DateTime.tryParse(fixedAt);
    if (parsed == null) {
      return null;
    }
    return SearchOrigin(
      latitude: latitude.toDouble(),
      longitude: longitude.toDouble(),
      isGps: json['is_gps'] == true,
      fixedAt: parsed.toUtc(),
      areaId: json['area_id'] as int?,
      areaName: json['area_name'] as String?,
    );
  }
}
