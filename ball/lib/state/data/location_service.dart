import 'package:ball/state/data/permissions.dart';
import 'package:ball/state/models/utils/ext.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // This class is responsible for managing location-related data and services.
  // It includes methods for fetching the user's current location, handling
  // location permissions, and other location-related functionalities.

  final permissions = Permissions();

  // Example method to fetch the current location
  Future<Position?> fetchCurrentLocation() async {
    final locationPermission = await _checkLocationPermissions();

    if (locationPermission != PermissionStatus.granted) {
      return null;
    }

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        serviceEnabled.debugLog(message: 'Location services are disabled');
        return null;
        // Future.error('Location services are disabled');
      }
    }

    try {

      final location = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 10,
        ),
      );

      return location;
      
    } on  PlatformException catch (e) {
      e.debugLog();
      return null;
    }

    
  }

  // Check location permissions
  Future<PermissionStatus> _checkLocationPermissions() async {
    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.permanentlyDenied ||
        permission == PermissionStatus.denied) {
      await Geolocator.openAppSettings();
      return permission;
    }

    return permission;
  }
}
