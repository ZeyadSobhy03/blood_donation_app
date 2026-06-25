import 'dart:developer';

import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/appointment_list_model.dart';
import '../../data/models/appointment_detail_model.dart';
import '../../data/models/verify_appointment_qr_model.dart';
import '../../data/models/verify_appointment_response_model.dart';
import '../../data/models/donation_complete_model.dart';
import '../../domain/use_cases/appointments_use_case.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsUseCase appointmentsUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  AppLocalizations? _loc;

  AppointmentsCubit({
    required this.appointmentsUseCase,
    required this.hospitalLocalDataSource,
  }) : super(AppointmentsInitialState());

  void setAppLoc(AppLocalizations loc) => _loc = loc;

  List<AppointmentListItem> _appointments = [];

  List<AppointmentListItem> get appointments => _appointments;

  Future<void> loadAppointments() async {
    try {
      emit(AppointmentsLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.getAppointments(token: token);
      if (isClosed) return;

      if (result.success == true && result.data?.appointments != null) {
        _appointments = result.data!.appointments!;
        emit(AppointmentsLoadedState(appointments: _appointments));
      } else {
        emit(AppointmentsLoadedState(appointments: _appointments));
      }
    } catch (e) {
      log('AppointmentsCubit.loadAppointments error: $e');
      if (!isClosed) {
        emit(AppointmentsErrorState(
          message: _parseError(e.toString()),
        ));
      }
    }
  }

  Future<void> fetchAppointmentDetail(String appointmentId) async {
    try {
      emit(AppointmentDetailLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.getAppointmentDetail(
        token: token,
        appointmentId: appointmentId,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(AppointmentDetailLoadedState(
          detail: result.data!,
          appointmentId: appointmentId,
        ));
      } else {
        emit(AppointmentDetailErrorState(
          message: result.message ?? _loc?.failedLoadAppointmentDetails ?? 'Failed to load appointment details.',
        ));
      }
    } catch (e) {
      log('AppointmentsCubit.fetchAppointmentDetail error: $e');
      if (!isClosed) {
        emit(AppointmentDetailErrorState(
          message: _parseError(e.toString()),
        ));
      }
    }
  }

  Future<void> verifyQrCode(String qrToken) async {
    try {
      emit(VerifyQrLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.verifyQr(
        token: token,
        qrToken: qrToken,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(VerifyQrSuccessState(data: result.data!));
      } else {
        emit(VerifyQrErrorState(
          message: result.message ?? _loc?.qrVerificationFailed ?? 'QR verification failed.',
        ));
      }
    } catch (e) {
      log('AppointmentsCubit.verifyQrCode error: $e');
      if (!isClosed) {
        emit(VerifyQrErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> verifyAppointment({
    required String appointmentId,
    required String verificationSessionId,
    required bool idVerified,
    required bool questionnaireCompleted,
    required bool consentSigned,
    required bool screeningCompleted,
    required bool disqualifyingDiseaseFound,
    required List<String> disqualifyingDiseases,
    required String notes,
  }) async {
    try {
      emit(VerifyAppointmentLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.verifyAppointment(
        token: token,
        appointmentId: appointmentId,
        verificationSessionId: verificationSessionId,
        idVerified: idVerified,
        questionnaireCompleted: questionnaireCompleted,
        consentSigned: consentSigned,
        screeningCompleted: screeningCompleted,
        disqualifyingDiseaseFound: disqualifyingDiseaseFound,
        disqualifyingDiseases: disqualifyingDiseases,
        notes: notes,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(VerifyAppointmentSuccessState(data: result.data!));
      } else {
        emit(VerifyAppointmentErrorState(
          message: result.message ?? _loc?.verificationFailed ?? 'Verification failed.',
        ));
      }
    } catch (e) {
      log('AppointmentsCubit.verifyAppointment error: $e');
      if (!isClosed) {
        emit(VerifyAppointmentErrorState(
          message: _parseError(e.toString()),
        ));
      }
    }
  }

  Future<void> completeDonation({
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  }) async {
    try {
      emit(DonationCompleteLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.completeDonation(
        token: token,
        appointmentId: appointmentId,
        hemoglobinLevel: hemoglobinLevel,
        weight: weight,
        unitsCollected: unitsCollected,
        notes: notes,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(DonationCompleteSuccessState(data: result.data!));
      } else {
        emit(DonationCompleteErrorState(
          message: result.message ?? _loc?.failedCompleteDonation ?? 'Failed to complete donation.',
        ));
      }
    } catch (e) {
      log('AppointmentsCubit.completeDonation error: $e');
      if (!isClosed) {
        emit(DonationCompleteErrorState(
          message: _parseError(e.toString()),
        ));
      }
    }
  }

  Future<void> rejectAppointment({
    required String appointmentId,
    required String reason,
  }) async {
    try {
      emit(AppointmentRejectLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await appointmentsUseCase.rejectAppointment(
        token: token,
        appointmentId: appointmentId,
        reason: reason,
      );
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        emit(AppointmentRejectSuccessState());
      } else {
        emit(AppointmentRejectErrorState(
          message: result.message ?? _loc?.failedRejectAppointment ?? 'Failed to reject appointment.',
        ));
      }
    } catch (e) {
      log('AppointmentsCubit.rejectAppointment error: $e');
      if (!isClosed) {
        emit(AppointmentRejectErrorState(
          message: _parseError(e.toString()),
        ));
      }
    }
  }

  void resetToAppointments() {
    emit(AppointmentsLoadedState(appointments: _appointments));
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
    if (e.contains('not_found')) return _loc?.notFoundItem ?? 'Not found.';
    if (e.contains('invalid_qr')) return _loc?.invalidQrCode ?? 'Invalid QR code.';
    if (e.contains('qr_expired')) return _loc?.qrCodeExpired ?? 'This QR code has expired.';
    if (e.contains('validation_error')) {
      return _loc?.checkAllFields ?? 'Please check all fields and try again.';
    }
    if (e.contains('access_denied') || e.contains('forbidden')) {
      return _loc?.accessDenied ?? 'Access denied.';
    }
    if (e.contains('already_completed')) {
      return _loc?.donationAlreadyCompleted ?? 'This donation has already been completed.';
    }
    if (e.contains('appointment_cancelled')) {
      return _loc?.appointmentCancelled ?? 'This appointment has been cancelled.';
    }
    return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }
}

sealed class AppointmentsState {}

class AppointmentsInitialState extends AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsLoadedState extends AppointmentsState {
  final List<AppointmentListItem> appointments;
  AppointmentsLoadedState({required this.appointments});
}

class AppointmentsErrorState extends AppointmentsState {
  final String message;
  AppointmentsErrorState({required this.message});
}

class AppointmentDetailLoadingState extends AppointmentsState {}

class AppointmentDetailLoadedState extends AppointmentsState {
  final AppointmentDetailData detail;
  final String appointmentId;
  AppointmentDetailLoadedState({required this.detail, required this.appointmentId});
}

class AppointmentDetailErrorState extends AppointmentsState {
  final String message;
  AppointmentDetailErrorState({required this.message});
}

class VerifyQrLoadingState extends AppointmentsState {}

class VerifyQrSuccessState extends AppointmentsState {
  final VerifyAppointmentQrData data;
  VerifyQrSuccessState({required this.data});
}

class VerifyQrErrorState extends AppointmentsState {
  final String message;
  VerifyQrErrorState({required this.message});
}

class VerifyAppointmentLoadingState extends AppointmentsState {}

class VerifyAppointmentSuccessState extends AppointmentsState {
  final VerifyAppointmentResponseData data;
  VerifyAppointmentSuccessState({required this.data});
}

class VerifyAppointmentErrorState extends AppointmentsState {
  final String message;
  VerifyAppointmentErrorState({required this.message});
}

class DonationCompleteLoadingState extends AppointmentsState {}

class DonationCompleteSuccessState extends AppointmentsState {
  final DonationCompleteData data;
  DonationCompleteSuccessState({required this.data});
}

class DonationCompleteErrorState extends AppointmentsState {
  final String message;
  DonationCompleteErrorState({required this.message});
}

class AppointmentRejectLoadingState extends AppointmentsState {}

class AppointmentRejectSuccessState extends AppointmentsState {}

class AppointmentRejectErrorState extends AppointmentsState {
  final String message;
  AppointmentRejectErrorState({required this.message});
}
