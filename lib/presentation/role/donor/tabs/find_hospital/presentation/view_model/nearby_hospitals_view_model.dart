import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/domain/use_case/nearby_hospitals_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyHospitalsCubit extends Cubit<NearbyHospitalsState> {
  final NearbyHospitalsUseCase nearbyHospitalsUseCase;

  NearbyHospitalsCubit({
    required this.nearbyHospitalsUseCase,
  }) : super(NearbyHospitalsInitialState());



  Future<void> fetchNearbyHospitals({
    required double latitude,
    required double longitude,
    double radius = 10,
    String? search,
    String? bloodType,
    String sortBy = 'distance',
    String order = 'asc',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      emit(NearbyHospitalsLoadingState());


      final nearbyHospitals =
      await nearbyHospitalsUseCase.getNearbyHospitals(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        search: search,
        bloodType: bloodType,
        sortBy: sortBy,
        order: order,
        page: page,
        limit: limit,
      );

      if (nearbyHospitals.success == true &&
          nearbyHospitals.data != null) {
        emit(
          NearbyHospitalsSuccessState(
            nearbyHospitals: nearbyHospitals,
          ),
        );
      } else {
        emit(
          NearbyHospitalsErrorState(
            error: 'Failed to load nearby hospitals',
          ),
        );
      }
    } catch (e) {
      emit(
        NearbyHospitalsErrorState(
          error: e.toString(),
        ),
      );
    }
  }
  Future<void>searchNearbyHospitals({
    required String query,
    String? bloodType,
    bool? availableOnly,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      emit(NearbyHospitalsLoadingState());
      final nearbyHospitals = await nearbyHospitalsUseCase.searchNearbyHospitals(
        query: query,
        bloodType: bloodType,
        availableOnly: availableOnly,
        page: page,
        limit: limit,
      );
      if (nearbyHospitals.success == true &&
          nearbyHospitals.data != null) {
        emit(
          NearbyHospitalsSuccessState(
            nearbyHospitals: nearbyHospitals,
          ),
        );
      } else {
        emit(
          NearbyHospitalsErrorState(
            error: 'Failed to search nearby hospitals',
          ),
        );
      }
    } catch (e) {
      emit(
        NearbyHospitalsErrorState(
          error: e.toString(),
        ),
      );


    }



}


}

sealed class NearbyHospitalsState {}

class NearbyHospitalsInitialState extends NearbyHospitalsState {}

class NearbyHospitalsLoadingState extends NearbyHospitalsState {}

class NearbyHospitalsSuccessState extends NearbyHospitalsState {
  final NearbyHospitals nearbyHospitals;

  NearbyHospitalsSuccessState({
    required this.nearbyHospitals,
  });
}

class NearbyHospitalsErrorState extends NearbyHospitalsState {
  final String error;

  NearbyHospitalsErrorState({
    required this.error,
  });
}