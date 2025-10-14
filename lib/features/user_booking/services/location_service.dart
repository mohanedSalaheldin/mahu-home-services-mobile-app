// services/location_service.dart
import 'package:geocoding/geocoding.dart';
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

  // static Future<Position?> getCurrentLocation() async {
  //   try {
  //     // Check permissions
  //     final status = await Permission.location.request();
  //     if (status != PermissionStatus.granted) {
  //       return null;
  //     }

  //     // Get current position
  //     final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     return position;
  //   } catch (e) {
  //     print('Location error: $e');
  //     return null;
  //   }
  // }

  // static Future<bool> checkLocationPermission() async {
  //   final status = await Permission.location.status;
  //   return status == PermissionStatus.granted;
  // }

  // static Future<void> requestLocationPermission() async {
  //   await Permission.location.request();
  // }

  /// 🆕 Get address (street, city, country) from latitude & longitude
  static Future<List<Placemark>> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      return placemarks;
    } catch (e) {
      print("Error in reverse geocoding: $e");
      return [];
    }
  }
}
