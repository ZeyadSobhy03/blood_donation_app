import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/domain/use_case/nearby_hospitals_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyHospitalsCubit extends Cubit<NearbyHospitalsState> {
  final NearbyHospitalsUseCase nearbyHospitalsUseCase;

  NearbyHospitalsCubit({required this.nearbyHospitalsUseCase})
      : super(NearbyHospitalsInitialState());

  final List<Hospitals> hospitals = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false;

  void _resetPagination() {
    hospitals.clear();
    currentPage = 1;
    hasMore = true;
    isLoadingMore = false;
  }

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
    if (isLoadingMore || !hasMore && page > 1) return;

    try {
      if (page == 1) {
        _resetPagination();
        emit(NearbyHospitalsLoadingState());
      } else {
        isLoadingMore = true;
        emit(NearbyHospitalsPaginatingState());
      }

      final result = await nearbyHospitalsUseCase.getNearbyHospitals(
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

      if (result.success == true && result.data != null) {
        final incoming = result.data?.hospitals ?? [];

        hospitals.addAll(incoming);
        currentPage = page;
        hasMore = incoming.length >= limit;
        isLoadingMore = false;

        emit(NearbyHospitalsSuccessState(hospitals: List.unmodifiable(hospitals), hasMore: hasMore));
      } else {
        isLoadingMore = false;
        emit(NearbyHospitalsErrorState(error: 'server_error'));
      }
    } on NetworkTimeoutException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unauthorized'));
    } on NotFoundException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'not_found'));
    } on RequestCancelledException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unknown_error'));
    } catch (e) {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unknown_error'));
    }
  }

  Future<void> searchNearbyHospitals({
    required String query,
    String? bloodType,
    bool? availableOnly,
    int page = 1,
    int limit = 10,
  }) async {
    if (isLoadingMore || !hasMore && page > 1) return;

    try {
      if (page == 1) {
        _resetPagination();
        emit(NearbyHospitalsLoadingState());
      } else {
        isLoadingMore = true;
        emit(NearbyHospitalsPaginatingState());
      }

      final result = await nearbyHospitalsUseCase.searchNearbyHospitals(
        query: query,
        bloodType: bloodType,
        availableOnly: availableOnly,
        page: page,
        limit: limit,
      );

      if (result.success == true && result.data != null) {
        final incoming = result.data?.hospitals ?? [];

        hospitals.addAll(incoming);
        currentPage = page;
        hasMore = incoming.length >= limit;
        isLoadingMore = false;

        emit(NearbyHospitalsSuccessState(hospitals: List.unmodifiable(hospitals), hasMore: hasMore));
      } else {
        isLoadingMore = false;
        emit(NearbyHospitalsErrorState(error: 'server_error'));
      }
    } on NetworkTimeoutException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unauthorized'));
    } on NotFoundException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'not_found'));
    } on RequestCancelledException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unknown_error'));
    } catch (e) {
      isLoadingMore = false;
      emit(NearbyHospitalsErrorState(error: 'unknown_error'));
    }
  }

  Future<void> loadMore({
    double? latitude,
    double? longitude,
    String? searchQuery,
    String? bloodType,
    bool isAscending = true,
  }) async {
    if (isLoadingMore || !hasMore) return;

    final nextPage = currentPage + 1;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      await searchNearbyHospitals(
        query: searchQuery,
        bloodType: bloodType,
        availableOnly: true,
        page: nextPage,
      );
    } else if (latitude != null && longitude != null) {
      await fetchNearbyHospitals(
        latitude: latitude,
        longitude: longitude,
        bloodType: bloodType,
        order: isAscending ? 'asc' : 'desc',
        page: nextPage,
      );
    }
  }
}


sealed class NearbyHospitalsState {}

class NearbyHospitalsInitialState extends NearbyHospitalsState {}

class NearbyHospitalsLoadingState extends NearbyHospitalsState {}

class NearbyHospitalsPaginatingState extends NearbyHospitalsState {}

class NearbyHospitalsSuccessState extends NearbyHospitalsState {
  final List<Hospitals> hospitals;
  final bool hasMore;

  NearbyHospitalsSuccessState({
    required this.hospitals,
    required this.hasMore,
  });
}

class NearbyHospitalsErrorState extends NearbyHospitalsState {
  final String error;

  NearbyHospitalsErrorState({required this.error});
}