import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/google_maps_controller_hook_result.dart';

MapControllerHookResult useGoogleMapController() {
  // Store the controller reference in state
  final controllerRef = useState<GoogleMapController?>(null);

  useEffect(
    () {
      return () {
        final controller = controllerRef.value;
        // if (controller != null) {
        //   // rootBundle
        //   //     .loadString('assets/maps/light_map_style.json')
        //   //     .then((value) => mapStyle = value);
        //   controller.dispose();
        // }
      };
    },
    const [],
  ); // Empty dependency array means this effect runs once on mount and cleanup on unmount

  // Create a stable callback function that won't change on re-renders
  final onMapCreated = useCallback(
    (GoogleMapController controller) async {
      // When the map is created, store the controller reference
      controllerRef.value = controller;
    },
    const [],
  ); // Empty dependency array means this callback remains the same function instance

  return MapControllerHookResult(controllerRef.value, onMapCreated);

  // return use(const _GoogleMapsControllerHook());
}
