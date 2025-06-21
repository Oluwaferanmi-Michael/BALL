import 'package:ball/components/floating_navbar_components/floating_nav_bar.dart';
import 'package:ball/components/floating_navbar_components/map_location_info_component.dart';
import 'package:ball/components/loading_indicator.dart';
import 'package:ball/state/hooks/custom_marker_hook.dart';
import 'package:ball/state/hooks/google_map_hook.dart';
import 'package:ball/state/hooks/models/basketball_locations_model.dart';
import 'package:ball/state/models/enums/enums.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:ball/state/models/location_information.dart';
import 'package:ball/state/provider/user_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ball/constants/app_constans.dart';
import 'package:ball/state/models/locations.dart';
import 'package:ball/state/notifier/court_location_service_notifier.dart';
import 'package:ball/state/notifier/polyline_data_notifier.dart';

class CourtMapPage extends HookConsumerWidget {
  const CourtMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers

    // final permission = ref.watch(locationPermissionProvider);

    // Hooks
    final mapsController = useGoogleMapController();
    final markerSet = useState<Set<Marker>>({});

    final userIcon = useUserMarkerIcon();

    final isInformationVisible = useState(false);
    final locationInformation = useState(LocationInformation.empty());

    final chipScrollController = useScrollController();

    final customIcon = useCustomMarkerIcon();
    late Coordinates coordinates;
    final carouselController = useCarouselController();
    final destination = useState<LatLng?>(null);

    final overlayPortalController = OverlayPortalController();
    // useOverlayPortalController();

    final courtLocations = ref.watch(courtLocationServiceNotifierProvider);

    final polylineDataNotifier = ref.watch(
      polylineDataNotifierProvider.notifier,
    );

    final userLocation = ref.watch(userLocationProvider);

    Future<void> cameraUpdate(BasketballLocations court) async {
      await mapsController.controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(court.location.lat, court.location.lng),
            zoom: 12,
          ),
        ),
      );
    }

    useEffect(() {
      // if (location.value == null) return null;
      final markers = <Marker>{};

      courtLocations.when(
        data: (data) {
          for (final court in data) {
            final marker = Marker(
              onTap: () async {
                isInformationVisible.value = true;
                final locationInfo = LocationInformation(
                  name: court.title,
                  address: court.address,
                  city: court.city,
                  price: court.price,
                  image: court.imageUrl,
                );
                locationInformation.value = locationInfo;
                try {
                  final controller = mapsController.controller;

                  // location.debugLog(message: 'User Data: ');
                  // coordinates = Coordinates(
                  //   lat: location.lat,
                  //   lng: location.lng,
                  // );

                  markerSet.value.length.debugLog(message: 'Marker Set: ');

                  // await polylineDataNotifier.loadPolylineData(
                  //   source: coordinates,
                  //   destination: Coordinates(
                  //     lat: destination.value?.latitude as double,
                  //     lng: destination.value?.longitude as double,
                  //   ),
                  // );

                  // show marker info window
                  final isMarkerIdShowing = await controller
                      ?.isMarkerInfoWindowShown(MarkerId(court.address));
                  if (controller != null) {
                    if (!isMarkerIdShowing!) {
                      await controller.hideMarkerInfoWindow(
                        MarkerId(court.address),
                      );
                    } else {
                      await controller.showMarkerInfoWindow(
                        MarkerId(court.address),
                      );
                    }

                    // animate camera to marker position
                    await cameraUpdate(court);
                    chipScrollController.jumpTo(
                      data.indexOf(court).toDouble(),
                      // duration: const Duration(seconds: 1),
                      // curve: Curves.easeInOut,
                    );
                    destination.value = LatLng(
                      court.location.lat,
                      court.location.lng,
                    );
                  }
                } catch (e) {
                  e.debugLog(message: 'Error showing marker info window:');
                }
              },
              icon: customIcon,
              markerId: MarkerId(court.address),
              position: LatLng(court.location.lat, court.location.lng),
              infoWindow: InfoWindow(
                title: '${court.title} ${court.neighborhood}',
                snippet: court.address,
              ),
            );
            markers.add(marker);
          }
        },
        error: (error, stack) {
          error.debugLog(
            message:
                'Map Area Error, cannot retrieve court location, stack: $stack',
          );
        },
        loading: () {
          'retrieving court locations'.debugLog();
        },
      );

      markerSet.value = markers;
      return null;
    }, [courtLocations.value, customIcon, mapsController.controller]);

    return Scaffold(
      body: SafeArea(
        child: userLocation.when(
          data: (location) {
            return location.fold(
              (err) {
                err.debugLog(message: 'Left Side: unable to show userLocation');
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        child: Text(
                          err.message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                      AppButtonComponent(
                        onTap: () {
                          // ignore: unused_result
                          ref.refresh(userLocationProvider);
                        },
                        type: ButtonType.primary,
                        label: 'Enable Location Service',
                      ),
                    ],
                  ),
                );
              },
              (location) {
                LatLng initialTarget = LatLng(location.lat, location.lng);

                // add user marker
                markerSet.value = {
                  Marker(
                    markerId: const MarkerId('user_location'),
                    position: LatLng(location.lat, location.lng),
                    zIndex: 5,
                    icon: userIcon,
                    // infoWindow: InfoWindow(
                    //   title: 'Your Location',
                    //   snippet: '${location.lat}, ${location.lng}',
                    // ),
                  ),
                  ...markerSet.value,
                };
                return Stack(
                  children: [
                    GoogleMap(
                      cloudMapId: AssetConstants.cloudMapStyle,

                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      padding: const EdgeInsets.all(12),
                      onMapCreated: mapsController.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: initialTarget,
                        tilt: 24.440717697143555,
                        zoom: 12,
                        // zoom: 10,
                      ),
                      markers: {...markerSet.value},
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      widthFactor: 1,
                      child: Visibility(
                        visible: isInformationVisible.value,
                        replacement: const SizedBox.shrink(),
                        child: LocationInfoWidget(
                          locationInformation: locationInformation,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: kBottomNavigationBarHeight * 1.2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: MediaQuery.sizeOf(context).width,
                        height: 42,
                        child: ListView.separated(
                          controller: chipScrollController,
                          itemCount: courtLocations.value!.length,
                          // padding: EdgeInsets.only(left: 8),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return ActionChip(
                              onPressed: () async {
                                isInformationVisible.value = true;
                                final locationInfo = LocationInformation(
                                  name: courtLocations.value![index].title,
                                  address: courtLocations.value![index].address,
                                  city: courtLocations.value![index].city,
                                  price: courtLocations.value![index].price,
                                  image: courtLocations.value![index].imageUrl,
                                );
                                locationInformation.value = locationInfo;

                                await cameraUpdate(
                                  courtLocations.value![index],
                                );
                              },
                              label: Text(
                                '${courtLocations.value![index].title}, ${courtLocations.value![index].city}',
                                style: GoogleFonts.poppins(fontSize: 10),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          error: (err, stack) {
            err.debugLog(message: 'userlocation provider.when');
            return Center(child: Text('err: $err, stack: $stack'));
          },
          loading: () => const Loadingindicator(),
        ),
      ),
    );
  }
}
