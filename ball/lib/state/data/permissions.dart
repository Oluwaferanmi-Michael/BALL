import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  Future<PermissionStatus> locationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
      Permission.location
          .onDeniedCallback(() async {
            await Geolocator.openAppSettings();
          })
          .onPermanentlyDeniedCallback(() async {
            await Geolocator.openAppSettings();
          });
      return status;
    }
    return status;
  }

  Future<void> seekPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await Geolocator.openAppSettings();
    }
  }
}
