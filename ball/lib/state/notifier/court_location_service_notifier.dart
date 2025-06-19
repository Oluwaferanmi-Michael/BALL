import 'dart:async';
import 'dart:convert';

import 'package:ball/state/hooks/models/basketball_locations_model.dart';
import 'package:flutter/services.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'court_location_service_notifier.g.dart';

@riverpod
class CourtLocationServiceNotifier extends _$CourtLocationServiceNotifier {
  @override
  Future<List<BasketballLocations>> build() async {
    final location = await getBasketBallCourts();

    return location;
  }

  Future<List<BasketballLocations>> getBasketBallCourts() async {
    const googleLocationsURL = 'assets/basketball_courts_in_nigeria.json';
    // File file = File(googleLocationsURL);
    // final data = await file.readAsString();
    final jsonFile = await rootBundle.loadString(googleLocationsURL);

    final result = (json.decode(jsonFile) as List).cast<Map<String, dynamic>>();

    final locations = result
        .map((e) => BasketballLocations.fromJson(e))
        .toList();
    return locations;
  }
}
