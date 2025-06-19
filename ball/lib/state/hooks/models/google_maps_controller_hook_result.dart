import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControllerHookResult {
  /// The controller reference (may be null before map is created)
  final GoogleMapController? controller;

  /// Callback to be used with GoogleMap's onMapCreated property
  final void Function(GoogleMapController) onMapCreated;

  MapControllerHookResult(this.controller, this.onMapCreated);
}
