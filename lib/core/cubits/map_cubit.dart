import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    _determinePosition();
  }

  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  )  {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  Future<void> _determinePosition() async {
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
    Position position = await Geolocator.getCurrentPosition();
    emit(
      MapLoaded(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
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
