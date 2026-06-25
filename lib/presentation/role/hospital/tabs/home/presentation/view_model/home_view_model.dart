import 'dart:developer';

import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/home_dashboard_model.dart';
import '../../data/models/home_activity_model.dart';
import '../../data/models/home_requests_model.dart';
import '../../data/models/home_request_detail_model.dart';
import '../../data/models/home_request_responses_model.dart';
import '../../data/models/home_nearby_donors_model.dart';
import '../../domain/use_cases/home_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  final AppLocalizations? loc;

  HomeCubit({
    required this.homeUseCase,
    required this.hospitalLocalDataSource,
    this.loc,
  }) : super(HomeInitialState());


  HomeDashboardData? _dashboard;
  List<ActivityItem> _activity = [];
  List<HomeRequestItem> _requests = [];
  List<BloodTypeDonorGroup> _nearbyDonorGroups = [];
  String? _hospitalName;

  HomeDashboardData? get dashboard => _dashboard;
  List<ActivityItem> get activity => _activity;
  List<HomeRequestItem> get requests => _requests;
  List<BloodTypeDonorGroup> get nearbyDonorGroups => _nearbyDonorGroups;
  String? get hospitalName => _hospitalName;

  Future<void> loadHome() async {
    try {
      emit(HomeLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final results = await Future.wait([
        homeUseCase.getDashboard(token: token),
        homeUseCase.getActivity(token: token),
        homeUseCase.getRequests(token: token, page: 1, limit: 20),
        homeUseCase.getNearbyDonorGroups(token: token),
        homeUseCase.getProfile(token: token),
      ]);
      if (isClosed) return;

      final dashboardResult = results[0] as HomeDashboardModel;
      final activityResult  = results[1] as HomeActivityModel;
      final requestsResult  = results[2] as HomeRequestsModel;
      final nearbyResult    = results[3] as HomeNearbyDonorsModel;
      final profileResult   = results[4] as HospitalProfileModel;

      _dashboard = dashboardResult.data;
      _activity = activityResult.data?.activities ?? [];
      _requests = HomeCubit.filterActiveRequests(requestsResult.data?.requests ?? []);
      _nearbyDonorGroups = nearbyResult.data?.groups ?? [];
      _hospitalName = profileResult.data?.hospitalName;

      emit(HomeLoadedState(
        dashboard: _dashboard,
        activity: _activity,
        requests: _requests,
        nearbyDonorGroups: _nearbyDonorGroups,
        hospitalName: _hospitalName,
      ));
    } catch (e) {
      log('HomeCubit.loadHome error: $e');
      if (!isClosed) {
        emit(HomeErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> refreshRequests() async {
    try {
      final token = await _getToken();
      if (isClosed) return;

      final requestsResult = await homeUseCase.getRequests(
        token: token,
        page: 1,
        limit: 20,
      );
      if (isClosed) return;

      _requests = HomeCubit.filterActiveRequests(requestsResult.data?.requests ?? []);

      emit(HomeLoadedState(
        dashboard: _dashboard,
        activity: _activity,
        requests: _requests,
        nearbyDonorGroups: _nearbyDonorGroups,
        hospitalName: _hospitalName,
      ));
    } catch (e) {
      log('HomeCubit.refreshRequests error: $e');
      if (!isClosed) {
        emit(HomeErrorState(message: _parseError(e.toString())));
      }
    }
  }

  static List<HomeRequestItem> filterActiveRequests(List<HomeRequestItem> items) {
    return items.where((r) {
      final raw = (r.requestStatus ?? r.status ?? '').toLowerCase().trim();
      return !raw.contains('completed') &&
          !raw.contains('cancelled') &&
          !raw.contains('expired');
    }).toList();
  }

  Future<void> fetchRequestDetail(String requestId) async {
    try {
      emit(RequestDetailLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await homeUseCase.getRequestDetail(
        token: token,
        requestId: requestId,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(RequestDetailLoadedState(detail: result.data!, requestId: requestId));
      } else {
        emit(RequestDetailErrorState(
          message: result.message ?? loc?.failedLoadRequestDetails ?? 'Failed to load request details.',
        ));
      }
    } catch (e) {
      log('HomeCubit.fetchRequestDetail error: $e');
      if (!isClosed) {
        emit(RequestDetailErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      emit(RequestActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await homeUseCase.updateRequestStatus(
        token: token,
        requestId: requestId,
        status: status,
      );
      if (isClosed) return;

      if (result.success == true) {
        emit(RequestActionSuccessState(
          message: result.message ?? loc?.requestUpdatedSuccess ?? 'Request updated successfully.',
        ));
        await refreshRequests();
      } else {
        emit(RequestActionErrorState(
          message: result.message ?? loc?.failedUpdateRequest ?? 'Failed to update request.',
        ));
      }
    } catch (e) {
      log('HomeCubit.updateRequestStatus error: $e');
      if (!isClosed) {
        emit(RequestActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> updateRequest({
    required String requestId,
    required String status,
    required List<String> bloodTypes,
    required String urgency,
    required int unitsNeeded,
    required String requiredBy,
    required String patientType,
    required String contactNumber,
    required String patientDetails,
  }) async {
    try {
      emit(RequestActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await homeUseCase.updateRequest(
        token: token,
        requestId: requestId,
        status: status,
        bloodTypes: bloodTypes,
        urgency: urgency,
        unitsNeeded: unitsNeeded,
        requiredBy: requiredBy,
        patientType: patientType,
        contactNumber: contactNumber,
        patientDetails: patientDetails,
      );
      if (isClosed) return;

      if (result.success == true) {
        emit(RequestActionSuccessState(
          message: result.message ?? loc?.requestUpdatedSuccess ?? 'Request updated successfully.',
        ));
        await refreshRequests();
      } else {
        emit(RequestActionErrorState(
          message: result.message ?? loc?.failedUpdateRequest ?? 'Failed to update request.',
        ));
      }
    } catch (e) {
      log('HomeCubit.updateRequest error: $e');
      if (!isClosed) {
        emit(RequestActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> cancelRequest(String requestId) async {
    try {
      emit(RequestActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      await homeUseCase.cancelRequest(token: token, requestId: requestId);
      if (isClosed) return;

      _requests.removeWhere((r) => r.id == requestId);

      emit(RequestActionSuccessState(message: loc?.requestCancelledSuccess ?? 'Request cancelled successfully.'));
      emit(HomeLoadedState(
        dashboard: _dashboard,
        activity: _activity,
        requests: _requests,
        nearbyDonorGroups: _nearbyDonorGroups,
        hospitalName: _hospitalName,
      ));
    } catch (e) {
      log('HomeCubit.cancelRequest error: $e');
      if (!isClosed) {
        emit(RequestActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> fetchRequestResponses(String requestId) async {
    try {
      emit(RequestResponsesLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await homeUseCase.getRequestResponses(
        token: token,
        requestId: requestId,
      );
      if (isClosed) return;

      if (result.success == true) {
        emit(RequestResponsesLoadedState(
          donors: result.data?.donors ?? [],
          requestId: requestId,
        ));
      } else {
        emit(RequestResponsesErrorState(
          message: result.message ?? loc?.failedLoadDonorResponses ?? 'Failed to load donor responses.',
        ));
      }
    } catch (e) {
      log('HomeCubit.fetchRequestResponses error: $e');
      if (!isClosed) {
        emit(RequestResponsesErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<String> _getToken() async {
    final token = await hospitalLocalDataSource.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('UNAUTHORIZED');
    return token;
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return loc?.connectionTimedOut ?? 'Connection timed out. Please try again.';
    if (e.contains('no_internet') || e.contains('connectionerror')) {
      return loc?.noInternetConnection ?? 'No internet connection.';
    }
    if (e.contains('unauthorized')) return loc?.sessionExpired ?? 'Session expired. Please log in again.';
    if (e.contains('not_found')) return loc?.requestNotFound ?? 'Request not found.';
    if (e.contains('validation_error')) {
      return loc?.checkAllFields ?? 'Please check all fields and try again.';
    }
    if (e.contains('unknown_error') || e.contains('bad_response')) {
      return loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
    }
    if (e.contains('access_denied') || e.contains('forbidden')) {
      return loc?.accessDenied ?? 'Access denied.';
    }
    return loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }
}

sealed class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final HomeDashboardData? dashboard;
  final List<ActivityItem> activity;
  final List<HomeRequestItem> requests;
  final List<BloodTypeDonorGroup> nearbyDonorGroups;
  final String? hospitalName;

  HomeLoadedState({
    required this.dashboard,
    required this.activity,
    required this.requests,
    required this.nearbyDonorGroups,
    required this.hospitalName,
  });
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}

class RequestDetailLoadingState extends HomeState {}

class RequestDetailLoadedState extends HomeState {
  final HomeRequestDetailData detail;
  final String requestId;
  RequestDetailLoadedState({required this.detail, required this.requestId});
}

class RequestDetailErrorState extends HomeState {
  final String message;
  RequestDetailErrorState({required this.message});
}

class RequestActionLoadingState extends HomeState {}

class RequestActionSuccessState extends HomeState {
  final String message;
  RequestActionSuccessState({required this.message});
}

class RequestActionErrorState extends HomeState {
  final String message;
  RequestActionErrorState({required this.message});
}

class RequestResponsesLoadingState extends HomeState {}

class RequestResponsesLoadedState extends HomeState {
  final List<RequestDonorResponse> donors;
  final String requestId;
  RequestResponsesLoadedState({required this.donors, required this.requestId});
}

class RequestResponsesErrorState extends HomeState {
  final String message;
  RequestResponsesErrorState({required this.message});
}
