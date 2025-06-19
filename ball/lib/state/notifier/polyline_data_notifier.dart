import 'package:ball/state/data/polyline_service.dart';
import 'package:ball/state/hooks/models/polyline_route_model.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/locations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'polyline_data_notifier.g.dart';

@riverpod
class PolylineDataNotifier extends _$PolylineDataNotifier {
  @override
  Future<PolylineRoute> build() async {
    return PolylineRoute.empty();
  }

  final polylineApi = PolylineService();

  Future<void> loadPolylineData({
    required Coordinates source,
    required Coordinates destination,
  }) async {
    try {
      final data = await polylineApi.getPolyline(
        destination: destination,
        source: source,
      );

      // final decoded = decodePolyline(data['geometry']['coordinates'] as String);

      // decoded.debugLog(message: 'Decoded polyline data: ');

      final polyline = PolylineRoute.fromJson(
        data,
        // newPolylineCoordinates: decoded,
      );

      // final decoded = decodePolyline();
      // polyline.geometry.coordinates
      state = AsyncData<PolylineRoute>(polyline);
    } catch (e) {
      e.debugLog(message: 'Error loading polyline data: $e');
      state = AsyncError(e, StackTrace.current);
    }
  }

  List<Coordinates> decodePolyline(String encoded) {
    List<Coordinates> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      // Decode latitude
      do {
        b = encoded.codeUnitAt(index++) - 63; // Get ASCII value and subtract 63
        result |= (b & 0x1f) << shift; // Take 5 lowest bits
        shift += 5;
      } while (b >=
          0x20); // Check continuation bit (0x20 is space, which is 63 + (-1) if b was -1 from a prev chunk)
      // More accurately, while the 6th bit (continuation bit) is set. 0x20 = 32.
      // If (b & 0x20) is non-zero, it means there's another chunk.

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      // Decode longitude
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      final latitude = lat / 1e5; // Divide by 1e5 for precision 5
      final longitude = lng / 1e5; // Divide by 1e5 for precision 5

      final coordinate = Coordinates(lat: latitude, lng: longitude);

      poly.add(coordinate); // Divide by 1e5 for precision 5
    }
    return poly;
  }
}
