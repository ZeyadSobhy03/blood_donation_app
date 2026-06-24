import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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

final class MapPermissionPermanentlyDenied extends MapState {}


class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    _startListening();
  }

  StreamSubscription<Position>? _positionSubscription;
  Position? _lastPosition;
  DateTime? _lastUpdateTime;
  String? _lastGovernorate;

  bool _isManuallyPicked = false;

  final double distanceThreshold = 2000; // 2 km
  final Duration timeThreshold = const Duration(minutes: 15);

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }


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
      if (_isManuallyPicked) return; // user is in control now, ignore GPS drift

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


  Future<void> pickLocation(double latitude, double longitude) async {
    _isManuallyPicked = true;
    emit(MapLoading());

    final info = await _getPlaceInfo(
      Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      ),
    );

    if (isClosed) return;

    _lastGovernorate = info.governorate;
    emit(MapLoaded(
      latitude: latitude,
      longitude: longitude,
      governorate: info.governorate,
      city: info.city,
    ));
  }

  void resumeGpsTracking() {
    _isManuallyPicked = false;
  }


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

    final info = await _getPlaceInfo(newPosition);
    if (_lastGovernorate == null || info.governorate != _lastGovernorate) {
      return true;
    }

    return false;
  }


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

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      emit(MapPermissionPermanentlyDenied());
      return false;
    }

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