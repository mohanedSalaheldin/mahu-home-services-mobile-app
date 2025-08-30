// services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    try {
      // Check permissions
      final status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      return position;
    } catch (e) {
      print('Location error: $e');
      return null;
    }
  }

  static Future<bool> checkLocationPermission() async {
    final status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  static Future<void> requestLocationPermission() async {
    await Permission.location.request();
  }
}