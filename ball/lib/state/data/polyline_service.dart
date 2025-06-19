import 'dart:convert';

import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/locations.dart';
import 'package:http/http.dart' as http;

class PolylineService {
  Future<Map<String, dynamic>> getPolyline({
    required Coordinates? destination,
    required Coordinates? source,
  }) async {
    if (destination == null || source == null) {
      destination?.debugLog(message: 'Destination is null');
      return {};
    }

    final coordinates =
        '${source.lat},${source.lng};${destination.lat},${destination.lng}';

    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/$coordinates?overview=false',
    );

    try {
      final polyline = await fetchPolyline(url);

      return polyline;
    } catch (e) {
      e.debugLog(message: 'Error fetching polyline: $e');
      return {};
    }
  }
}

Future<Map<String, dynamic>> fetchPolyline(Uri url) async {
  final req = await http.get(url);

  final res = jsonDecode(req.body) as Map<String, dynamic>;

  if (res['code'] != 'Ok') {
    res.debugLog(
      message:
          'Polyline Service Dart, Error fetching polyline: ${res['message']}',
    );
  }

  return res;
}
