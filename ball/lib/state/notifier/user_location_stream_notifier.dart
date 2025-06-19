import 'dart:async';

import 'package:ball/state/models/locations.dart';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_stream_notifier.g.dart';

@riverpod
class UserLocationNotifier extends _$UserLocationNotifier {
  @override
  Stream<UserLocation> build() async* {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    final StreamController<UserLocation> positionStreamController =
        StreamController<UserLocation>();

    final sub = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(
          (position) {
            final currentPosition = position;
            final userLocation = UserLocation(
              lat: currentPosition.latitude,
              lng: currentPosition.longitude,
            );
            positionStreamController.add(userLocation);
          },
          onError: (error) {
            // print('Error getting user location: $error');
          },
        );

    await for (final userLocation in positionStreamController.stream) {
      yield userLocation;
    }

    ref.onDispose(() {
      sub.cancel;
    });
  }
}


