import 'dart:developer';

import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_enum_mapper.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/domain/use_cases/request_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RequestCubit extends Cubit<RequestState> {
  final RequestUseCase requestUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  AppLocalizations? _loc;

  RequestCubit({
    required this.requestUseCase,
    required this.hospitalLocalDataSource,
  }) : super(RequestInitialState());

  void setAppLoc(AppLocalizations loc) => _loc = loc;

  Future<void> createRequest({
    required Set<String> selectedBloodTypes,
    required String? selectedUrgencyDisplay,
    required DateTime? requiredByDate,
    required String? selectedPatientTypeDisplay,
    required String contactNumber,
    required String? selectedPatientDetailsDisplay,
    required int unitsNeeded,
    required AppLocalizations loc,
  }) async {
    try {
      emit(RequestLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await requestUseCase.createRequest(
        token: token,
        bloodTypes: selectedBloodTypes.toList(),
        urgency: _mapUrgency(selectedUrgencyDisplay, loc),
        requiredBy: _formatDate(requiredByDate),
        unitsNeeded: unitsNeeded,
        patientType: _mapPatientType(selectedPatientTypeDisplay, loc),
        contactNumber: contactNumber,
        patientDetails: RequestEnumMapper.patientDetailsDisplayToKey(selectedPatientDetailsDisplay, loc),
      );
      if (isClosed) return;

      if (result.success == true) {
        emit(RequestSuccessState(request: result));
      } else {
        emit(RequestErrorState(message: result.message ?? 'Request failed.'));
      }
    } catch (e) {
      log('RequestCubit.createRequest error: $e');
      if (!isClosed) {
        emit(RequestErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> createEmergencyRequest({
    required String bloodType,
    required int unitsNeeded,
    required String? selectedPatientDetailsDisplay,
    required AppLocalizations loc,
  }) async {
    try {
      emit(RequestLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await requestUseCase.createEmergencyRequest(
        token: token,
        bloodType: bloodType,
        unitsNeeded: unitsNeeded,
        patientDetails: RequestEnumMapper.patientDetailsDisplayToKey(selectedPatientDetailsDisplay, loc),
      );
      if (isClosed) return;

      if (result.success == true) {
        emit(EmergencyRequestSuccessState(request: result));
      } else {
        emit(RequestErrorState(message: result.message ?? 'Emergency request failed.'));
      }
    } catch (e) {
      log('RequestCubit.createEmergencyRequest error: $e');
      if (!isClosed) {
        emit(RequestErrorState(message: _parseError(e.toString())));
      }
    }
  }

  void reset() => emit(RequestInitialState());

  String _mapUrgency(String? display, AppLocalizations loc) {
    if (display == null) return 'critical';
    if (display == loc.critical) return 'critical';
    if (display == loc.urgency_high)     return 'high';
    if (display == loc.urgency_medium)   return 'medium';
    if (display == loc.urgency_low)      return 'low';
    return 'critical';
  }

  String _mapPatientType(String? display, AppLocalizations loc) {
    if (display == null) return 'adult';
    if (display == loc.patientTypeAdult)  return 'adult';
    if (display == loc.patientTypeChild)  return 'child';
    if (display == loc.patientTypeInfant) return 'infant';
    return 'adult';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
  }

  Future<String> _getToken() async {
    final token = await hospitalLocalDataSource.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('UNAUTHORIZED');
    return token;
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return _loc?.connectionTimedOut ?? 'Connection timed out. Please try again.';
    if (e.contains('no_internet') || e.contains('connectionerror')) {
      return _loc?.noInternetConnection ?? 'No internet connection.';
    }
    if (e.contains('unauthorized')) return _loc?.sessionExpired ?? 'Session expired. Please log in again.';
    if (e.contains('validation_error')) return _loc?.checkAllFields ?? 'Please check all fields and try again.';
    if (e.contains('unknown_error') || e.contains('bad_response')) {
      return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
    }
    if (e.contains('access_denied') || e.contains('forbidden')) {
      return _loc?.accessDenied ?? 'Access denied.';
    }
    if (e.contains('contact_required') || e.contains('hospital_contact')) {
      return _loc?.hospitalContactRequired ?? 'Please set a contact number in your profile before creating a request.';
    }
    return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }
}


sealed class RequestState {}

class RequestInitialState extends RequestState {}

class RequestLoadingState extends RequestState {}

class RequestSuccessState extends RequestState {
  final RequestModel request;

  RequestSuccessState({required this.request});

  String get requestId => request.data?.id ?? '';
  String get message   => request.message ?? 'Request created successfully.';
}

class EmergencyRequestSuccessState extends RequestState {
  final RequestModel request;

  EmergencyRequestSuccessState({required this.request});

  String get requestId => request.data?.id ?? '';
  String get message   => request.message ?? 'Emergency request created successfully.';
}

class RequestErrorState extends RequestState {
  final String message;

  RequestErrorState({required this.message});
}