import 'dart:async';

import 'package:ball/shared/libraries.dart';
import 'package:ball/state/provider/map_marker_provider.dart';

class CourtMap extends ConsumerStatefulWidget {
  const CourtMap({super.key, required this.initialTarget});

  final LatLng initialTarget;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourtMapState();
}

class _CourtMapState extends ConsumerState<CourtMap> {
  final Completer<GoogleMapController> _completer = Completer();

  late final Coordinates _initialCoordinates;

  @override
  void initState() {
    super.initState();
    _initialCoordinates = Coordinates(lat: widget.initialTarget.latitude, lng: widget.initialTarget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // final coordinates = Coordinates(
    //   lat: widget.initialTarget.latitude,
    //   lng: widget.initialTarget.longitude,
    // );

    _initialCoordinates.debugLog(message: 'User Initial Target Coordintes:');

    final courtMarkers = ref.watch(
      mapCourtMarkersProvider(
        futureController: _completer.future,
        userLocation: _initialCoordinates,
      ),
    );

    return GoogleMap(
      cloudMapId: AssetConstants.cloudMapStyle,
      zoomControlsEnabled: false,
      compassEnabled: false,
      padding: const EdgeInsets.all(12),
      onMapCreated: (controller) => _completer.complete(controller),
      initialCameraPosition: CameraPosition(
        target: widget.initialTarget,
        tilt: 24.440717697143555,
        zoom: 12,
      ),
      markers: courtMarkers.value ?? {},
    );
  }
}
