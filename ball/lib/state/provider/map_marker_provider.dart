import 'package:ball/shared/libraries.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'map_marker_provider.g.dart';

@riverpod
Future<Set<Marker>> mapCourtMarkers(
  Ref ref, {
  required Future<GoogleMapController> futureController,
  required Coordinates userLocation,
}) async {
  final courtLocations = ref.watch(courtLocationServiceNotifierProvider);
  courtLocations.debugLog(
    message: 'COURT LOCATION: ${courtLocations.toString()}',
  );

  Set<Marker> markers = {};

  final controller = await futureController;

  double width = 42;
  double height = 42;

  final configuration = ImageConfiguration(
    size: Size(width, height),
    devicePixelRatio: 2.0,
  );

  final userIcon = await BitmapDescriptor.asset(
    configuration,
    'assets/images/user_position.png',
  );

  final courtIcon = await BitmapDescriptor.asset(
    configuration,
    'assets/images/purple_bask.png',
  );

  final userMarker = Marker(
    markerId: const MarkerId('user_location'),
    position: LatLng(userLocation.lat, userLocation.lng),
    zIndex: 5,
    icon: userIcon,
    
    // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

  markers.add(userMarker);



  courtLocations.when(
    data: (courts) {
      for (BasketballLocations court in courts) {
        final marker = Marker(
          markerId: MarkerId(court.address),
          icon: courtIcon,
          onTap: () async {
            final locationInfo = LocationInformation(
              name: court.title,
              address: court.address,
              city: court.city,
              price: court.price,
              image: court.imageUrl,
            );

            try {
              await controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(court.location.lat, court.location.lng),
                    zoom: 12,
                  ),
                ),
              );

              // location.debugLog(message: 'User Data: ');
              // coordinates = Coordinates(
              //   lat: location.lat,
              //   lng: location.lng,
              // );

              // await polylineDataNotifier.loadPolylineData(
              //   source: coordinates,
              //   destination: Coordinates(
              //     lat: destination.value?.latitude as double,
              //     lng: destination.value?.longitude as double,
              //   ),
              // );

              ref.watch(showLocaleInfoNotifierProvider.notifier).show();
              ref
                  .watch(locationInformationNotifierProvider.notifier)
                  .setLocationInfo(locationInfo);

              // show marker info window
              final isMarkerIdShowing = await controller
                  .isMarkerInfoWindowShown(MarkerId(court.address));

              if (!isMarkerIdShowing) {
                await controller.hideMarkerInfoWindow(MarkerId(court.address));
              } else {
                await controller.showMarkerInfoWindow(MarkerId(court.address));
              }
            } catch (e) {
              e.debugLog(message: 'Error showing marker info window:');
            }
          },
          // icon: customIcon,
          position: LatLng(court.location.lat, court.location.lng),
          infoWindow: InfoWindow(
            title: '${court.title} ${court.neighborhood}',
            snippet: court.address,
          ),
        );
        markers.add(marker);
      }
    },
    error: (error, stackTrace) => AsyncError(error, stackTrace),
    loading: () => const AsyncLoading(),
  );

  return markers;
}

@riverpod
class ShowLocaleInfoNotifier extends _$ShowLocaleInfoNotifier {
  @override
  bool build() => false;

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}

@riverpod
class LocationInformationNotifier extends _$LocationInformationNotifier {
  @override
  LocationInformation build() => LocationInformation.empty();

  void setLocationInfo(LocationInformation info) => state = info;
}
