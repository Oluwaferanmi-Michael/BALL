
import 'package:flutter/material.dart' show ImageConfiguration;
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

BitmapDescriptor useCustomMarkerIcon(
    {double width = 42, double height = 42}) {
  final customIcon = useState<BitmapDescriptor>(
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

  final configuration = ImageConfiguration(
    size: Size(width, height),
    devicePixelRatio: 2.0,
  );

  final result = useMemoized(() async => await BitmapDescriptor.asset(
              configuration, 'assets/images/purple_bask.png')
          .then((icon) {
        customIcon.value = icon;
      }).catchError((error) {
        // error.debugLog(
        //     message: 'Failed to load custom marker: $error',
        //     );
      }));

  useFuture(result);

  return customIcon.value;
}

BitmapDescriptor useUserMarkerIcon(
    {double width = 42, double height = 42}) {
  final customIcon = useState<BitmapDescriptor>(
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

  final configuration = ImageConfiguration(
    size: Size(width, height),
    devicePixelRatio: 2.0,
  );

  final result = useMemoized(() async => await BitmapDescriptor.asset(
              configuration, 'assets/images/user_position.png')
          .then((icon) {
        customIcon.value = icon;
      }).catchError((error) {
        // print('Failed to load custom marker: $error');
      }));

  useFuture(result);

  return customIcon.value;
}
