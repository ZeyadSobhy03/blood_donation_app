import 'dart:developer';

import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/model/find_donors_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/domain/use_cases/find_donors_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindDonorsCubit extends Cubit<FindDonorsState> {
  final FindDonorsUseCase findDonorsUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  final AppLocalizations? loc;

  FindDonorsCubit({
    required this.findDonorsUseCase,
    required this.hospitalLocalDataSource,
    this.loc,
  }) : super(FindDonorsInitialState());

  int _currentPage = 1;
  static const int _pageSize = 20;

  final List<DonorModel> _allDonors = [];

  DonorPagination? _pagination;

  Future<void> fetchDonors({
    String? bloodType,
    double? radiusKm,
    bool availability = true,
  }) async {
    try {
      emit(FindDonorsLoadingState());

      _currentPage = 1;
      _allDonors.clear();

      final token = await _getToken();

      final result = await findDonorsUseCase(
        token: token,
        bloodType: bloodType,
        radiusKm: radiusKm,
        availability: availability,
        page: _currentPage,
        limit: _pageSize,
      );

      await _handleResult(result);
    } catch (e) {
      log('FindDonorsCubit.fetchDonors error: $e');
      emit(FindDonorsErrorState(message: _parseError(e.toString())));
    }
  }

  Future<void> loadMore({
    String? bloodType,
    double? radiusKm,
    bool availability = true,
  }) async {
    if (_pagination?.hasNextPage != true) return;
    if (state is FindDonorsPaginatingState) return;

    try {
      emit(FindDonorsPaginatingState(currentDonors: List.from(_allDonors)));

      _currentPage++;

      final token = await _getToken();

      final result = await findDonorsUseCase(
        token: token,
        bloodType: bloodType,
        radiusKm: radiusKm,
        availability: availability,
        page: _currentPage,
        limit: _pageSize,
      );

      await _handleResult(result);
    } catch (e) {
      log('FindDonorsCubit.loadMore error: $e');
      _currentPage--;
      emit(FindDonorsSuccessState(
        donors: List.from(_allDonors),
        pagination: _pagination,
      ));
    }
  }

  Future<void> _handleResult(FindDonorsModel result) async {
    _pagination = result.data?.pagination;

    final rawDonors = result.data?.donors ?? [];

    final List<DonorModel> newDonors = rawDonors.map((donor) {
      return donor.toDonorModel();
    }).toList();

    _allDonors.addAll(newDonors);

    if (_allDonors.isEmpty) {
      emit(FindDonorsEmptyState());
    } else {
      emit(FindDonorsSuccessState(
        donors: List.from(_allDonors),
        pagination: _pagination,
      ));
    }
  }

  Future<String> _getToken() async {
    final token = await hospitalLocalDataSource.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('UNAUTHORIZED');
    }
    return token;
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return loc?.connectionTimedOut ?? 'Connection timed out. Please try again.';
    if (e.contains('no_internet') || e.contains('connectionerror')) {
      return loc?.noInternetConnection ?? 'No internet connection.';
    }
    if (e.contains('unauthorized')) return loc?.sessionExpired ?? 'Session expired. Please log in again.';
    if (e.contains('access_denied')) return loc?.accessDenied ?? 'Access denied.';
    if (e.contains('hospital_not_found')) {
      return loc?.hospitalLocationNotSet ?? 'Hospital location not set. Please update your profile.';
    }
    return loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }

  void reset() => emit(FindDonorsInitialState());
}


sealed class FindDonorsState {}

class FindDonorsInitialState extends FindDonorsState {}

class FindDonorsLoadingState extends FindDonorsState {}

class FindDonorsSuccessState extends FindDonorsState {
  final List<DonorModel> donors;
  final DonorPagination? pagination;

  FindDonorsSuccessState({required this.donors, this.pagination});

  bool get hasMore => pagination?.hasNextPage ?? false;
  int get total => pagination?.total ?? donors.length;
}

class FindDonorsPaginatingState extends FindDonorsState {
  final List<DonorModel> currentDonors;

  FindDonorsPaginatingState({required this.currentDonors});
}

class FindDonorsEmptyState extends FindDonorsState {}

class FindDonorsErrorState extends FindDonorsState {
  final String message;

  FindDonorsErrorState({required this.message});
}