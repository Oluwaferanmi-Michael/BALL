class Coordinates {
  const Coordinates({required this.lat, required this.lng});

  Coordinates.fromJson(Map<String, dynamic> json)
    : lat = (json['lat'] as num).toDouble(),
      lng = (json['lng'] as num).toDouble();

  @override
  String toString() {
    return 'Coordinates(latitude: $lat, longitude: $lng)';
  }

  final double lat;
  final double lng;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinates &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode => Object.hash(lat, lng);
}

class UserLocation extends Coordinates {
  const UserLocation({required super.lat, required super.lng});
}
