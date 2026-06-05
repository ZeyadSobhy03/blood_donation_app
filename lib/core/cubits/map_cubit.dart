import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATES
// ─────────────────────────────────────────────────────────────────────────────

sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final double latitude;
  final double longitude;
  final String governorate;
  final String city;

  MapLoaded({
    required this.latitude,
    required this.longitude,
    required this.governorate,
    required this.city,
  });
}

final class MapError extends MapState {
  final String error;
  MapError(this.error);
}

/// Emitted when the user has permanently denied location permission.
/// The UI should guide the user to open app settings.
final class MapPermissionPermanentlyDenied extends MapState {}

// ─────────────────────────────────────────────────────────────────────────────
// CUBIT
// ─────────────────────────────────────────────────────────────────────────────

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    _startListening();
  }

  StreamSubscription<Position>? _positionSubscription;
  Position? _lastPosition;
  DateTime? _lastUpdateTime;
  String? _lastGovernorate;

  final double distanceThreshold = 2000; // 2 km
  final Duration timeThreshold = const Duration(minutes: 15);

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }

  // ── Entry point ─────────────────────────────────────────────────────────────

  void _startListening() async {
    final serviceEnabled = await _locationServiceEnabled();
    if (isClosed) return;
    if (!serviceEnabled) {
      emit(MapError('Location service is not enabled'));
      return;
    }

    final permissionGranted = await _checkPermission();
    if (!permissionGranted || isClosed) return; // _checkPermission already emitted a state

    emit(MapLoading());

    _positionSubscription = Geolocator.getPositionStream().listen((position) async {
      final shouldUpdate = await _shouldEmit(position);

      if (shouldUpdate && !isClosed) {
        _lastPosition = position;
        _lastUpdateTime = DateTime.now();

        final info = await _getPlaceInfo(position);
        _lastGovernorate = info.governorate;

        if (!isClosed) {
          emit(MapLoaded(
            latitude: position.latitude,
            longitude: position.longitude,
            governorate: info.governorate,
            city: info.city,
          ));
        }
      }
    });
  }

  // ── Throttle logic ───────────────────────────────────────────────────────────

  Future<bool> _shouldEmit(Position newPosition) async {
    // Always emit the very first fix
    if (_lastPosition == null) return true;

    final distance = Geolocator.distanceBetween(
      _lastPosition!.latitude,
      _lastPosition!.longitude,
      newPosition.latitude,
      newPosition.longitude,
    );

    if (distance >= distanceThreshold) return true;

    if (_lastUpdateTime != null &&
        DateTime.now().difference(_lastUpdateTime!) >= timeThreshold) {
      return true;
    }

    // Emit if the user crossed a governorate boundary
    final info = await _getPlaceInfo(newPosition);
    if (_lastGovernorate == null || info.governorate != _lastGovernorate) {
      return true;
    }

    return false;
  }

  // ── Geocoding ────────────────────────────────────────────────────────────────

  /// Returns governorate + city from a GPS position using reverse geocoding.
  ///
  /// Placemark field mapping:
  ///   administrativeArea      → Governorate  (e.g. "Cairo Governorate")
  ///   locality                → City/District (e.g. "Heliopolis")
  ///   subAdministrativeArea   → Fallback city if locality is null
  Future<({String governorate, String city})> _getPlaceInfo(
      Position position,
      ) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final p = placemarks.first;

      return (
      governorate: p.administrativeArea ?? 'Unknown',
      city: p.locality ??
          p.subAdministrativeArea ??
          p.administrativeArea ??
          'Unknown',
      );
    } catch (_) {
      return (governorate: 'Unknown', city: 'Unknown');
    }
  }


  Future<bool> _locationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Returns true if permission is granted.
  /// Emits [MapPermissionPermanentlyDenied] or [MapError] on failure
  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // Already permanently denied — cannot request again
    if (permission == LocationPermission.deniedForever) {
      emit(MapPermissionPermanentlyDenied());
      return false;
    }

    // Ask the user if not yet decided
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(MapPermissionPermanentlyDenied());
      return false;
    }

    if (permission == LocationPermission.denied) {
      emit(MapError('Location permission is not granted'));
      return false;
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}