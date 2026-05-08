import 'package:blood_donation_app/data/locations/location_repository.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/nearby_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/domain/use_cases/schedule_donation_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDonationCubit extends Cubit<ScheduleDonationState> {
  final ScheduleDonationUseCase scheduleDonationUseCase;
  final LocationRepository locationRepository;

  ScheduleDonationCubit({
    required this.scheduleDonationUseCase,
    required this.locationRepository,
  }) : super(ScheduleDonationInitialState());

  Future<void> fetchNearbyHospitals({double radiusKm = 10.0}) async {
    try {
      emit(ScheduleDonationLoadingState());

      final currentLocation = await locationRepository.getCurrentLocation();

      final response = await scheduleDonationUseCase.getNearbyHospitals(
        currentLocation.latitude,
        currentLocation.longitude,
        radiusKm,
      );


      final hospitalsList = response.data?.hospitals ?? [];

      if (hospitalsList.isEmpty) {
        emit(ScheduleDonationLoadedState(hospitals: hospitalsList));
      } else {
        emit(ScheduleDonationLoadedState(hospitals: hospitalsList));
      }
    } catch (e) {
      emit(
        ScheduleDonationErrorState(
          error: 'Failed to fetch nearby hospitals: ${e.toString()}',
        ),
      );
    }
  }


  void clearHospitals() {
    emit(ScheduleDonationInitialState());
  }

  Future<void> retryFetchingHospitals() async {
    if (state is ScheduleDonationErrorState) {
      await fetchNearbyHospitals();
    }
  }
}

sealed class ScheduleDonationState {}

class ScheduleDonationInitialState extends ScheduleDonationState {}

class ScheduleDonationLoadingState extends ScheduleDonationState {}


class ScheduleDonationLoadedState extends ScheduleDonationState {
  final List<Hospitals> hospitals;

  ScheduleDonationLoadedState({required this.hospitals});

  int get hospitalCount => hospitals.length;

  Hospitals? getHospitalAt(int index) {
    if (index < 0 || index >= hospitals.length) return null;
    return hospitals[index];
  }


  bool get isEmpty => hospitals.isEmpty;


  bool get hasHospitals => hospitals.isNotEmpty;
}

class ScheduleDonationErrorState extends ScheduleDonationState {
  final String error;

  ScheduleDonationErrorState({required this.error});


  bool get isLocationPermissionError =>
      error.toLowerCase().contains('permission');

  bool get isLocationServiceError => error.toLowerCase().contains('service');


  bool get isNetworkError => error.toLowerCase().contains('network');
}
