import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    _startListening();
  }

  Position? _lastPosition;
  DateTime? _lastUpdateTime;
  String? _lastGovernorate;

  final double distanceThreshold = 2000; // 2 KM
  final Duration timeThreshold = Duration(minutes: 15);

  void _startListening() async {
    bool serviceEnabled = await _locationServiceEnabled();
    if (!serviceEnabled) {
      emit(MapError('Location service is not enabled'));
      return;
    }

    bool isPermissionGranted = await _checkPermission();
    if (!isPermissionGranted) {
      emit(MapError('Location permission is not granted'));
      return;
    }

    emit(MapLoading());

    Geolocator.getPositionStream().listen((position) async {
      bool shouldUpdate = await _shouldEmit(position);

      if (shouldUpdate) {
        _lastPosition = position;
        _lastUpdateTime = DateTime.now();

        emit(MapLoaded(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      }
    });
  }

  Future<bool> _shouldEmit(Position newPosition) async {
    if (_lastPosition == null) return true;

    double distance = Geolocator.distanceBetween(
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

    String newGovernorate = await _getGovernorate(newPosition);

    if (_lastGovernorate == null) {
      _lastGovernorate = newGovernorate;
      return true;
    }

    if (newGovernorate != _lastGovernorate) {
      _lastGovernorate = newGovernorate;
      return true;
    }

    return false;
  }

  Future<String> _getGovernorate(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placemarks.first.administrativeArea ?? 'Unknown';
  }

  Future<bool> _locationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}

sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class MapLoaded extends MapState {
  final double latitude;
  final double longitude;

  MapLoaded({required this.latitude, required this.longitude});
}

final class MapError extends MapState {
  final String error;

  MapError(this.error);
}
