import 'package:geolocator/geolocator.dart';

/// Simple location models used across the app to avoid leaking geolocator types
/// into higher-level code and to make testing easier.
class DeviceLocation {
  final double latitude;
  final double longitude;

  DeviceLocation({required this.latitude, required this.longitude});
}

/// Abstraction for device/location operations used by cubits and services.
abstract class LocationRepository {
  Future<bool> isLocationServiceEnabled();

  /// Requests permission if needed and returns whether the app has a usable
  /// location permission (whileInUse or always).
  Future<bool> requestAndCheckPermission();

  /// Returns the current device location.
  Future<DeviceLocation> getCurrentLocation();

  /// Calculates distance in meters between two coordinates.
  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  );
}

/// Default implementation that delegates to `geolocator`.
class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> requestAndCheckPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<DeviceLocation> getCurrentLocation() async {
    Position p = await Geolocator.getCurrentPosition();
    return DeviceLocation(latitude: p.latitude, longitude: p.longitude);
  }

  @override
  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
