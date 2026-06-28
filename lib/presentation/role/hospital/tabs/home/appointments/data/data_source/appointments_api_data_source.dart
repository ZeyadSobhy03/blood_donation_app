import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:dio/dio.dart';

import '../models/appointment_list_model.dart';
import '../models/appointment_detail_model.dart';
import '../models/verify_appointment_qr_model.dart';
import '../models/verify_appointment_response_model.dart';
import '../models/donation_complete_model.dart';
import '../models/reject_appointment_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<AppointmentListModel> getAppointments({required String token});
  Future<AppointmentDetailModel> getAppointmentDetail({
    required String token,
    required String appointmentId,
  });
  Future<VerifyAppointmentQrModel> verifyQr({
    required String token,
    required String qrToken,
  });
  Future<VerifyAppointmentResponseModel> verifyAppointment({
    required String token,
    required String appointmentId,
    required String verificationSessionId,
    required bool idVerified,
    required bool questionnaireCompleted,
    required bool consentSigned,
    required bool screeningCompleted,
    required bool disqualifyingDiseaseFound,
    required List<String> disqualifyingDiseases,
    required String notes,
  });
  Future<DonationCompleteModel> completeDonation({
    required String token,
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  });
  Future<RejectAppointmentModel> rejectAppointment({
    required String token,
    required String appointmentId,
    required String reason,
  });
}

class AppointmentsApiDataSource implements AppointmentsRemoteDataSource {
  final Dio dio;

  AppointmentsApiDataSource(this.dio);

  Map<String, String> _authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  @override
  Future<AppointmentListModel> getAppointments({required String token}) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalAppointmentsEndpoint,
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return AppointmentListModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<AppointmentDetailModel> getAppointmentDetail({
    required String token,
    required String appointmentId,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalAppointmentByIdEndpoint(appointmentId),
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return AppointmentDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<VerifyAppointmentQrModel> verifyQr({
    required String token,
    required String qrToken,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.appointmentVerifyQrEndpoint,
        data: {'qrToken': qrToken},
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return VerifyAppointmentQrModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<VerifyAppointmentResponseModel> verifyAppointment({
    required String token,
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
      final response = await dio.post(
        ApiManger.appointmentVerifyEndpoint(appointmentId),
        data: {
          'verificationSessionId': verificationSessionId,
          'checklist': {
            'idVerified': idVerified,
            'questionnaireCompleted': questionnaireCompleted,
            'consentSigned': consentSigned,
          },
          'diseaseScreening': {
            'screeningCompleted': screeningCompleted,
            'disqualifyingDiseaseFound': disqualifyingDiseaseFound,
            'disqualifyingDiseases': disqualifyingDiseases,
            'notes': notes,
          },
        },
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return VerifyAppointmentResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<DonationCompleteModel> completeDonation({
    required String token,
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.donationCompleteEndpoint,
        data: {
          'appointmentId': appointmentId,
          'hemoglobinLevel': hemoglobinLevel,
          'weight': weight,
          'unitsCollected': unitsCollected,
          'notes': notes,
        },
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return DonationCompleteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<RejectAppointmentModel> rejectAppointment({
    required String token,
    required String appointmentId,
    required String reason,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.appointmentRejectEndpoint(appointmentId),
        data: {'reason': reason},
        options: Options(headers: _authHeaders(token)),
      );
      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
      if (response.data == null) throw Exception('EMPTY_RESPONSE');
      return RejectAppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  bool _isSuccess(int? code) => code != null && code >= 200 && code < 300;

  String _extractServerError(Response response) {
    final data = response.data;
    if (data is Map && data['message'] != null) return data['message'];
    return response.statusMessage ?? 'SERVER_ERROR';
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'CONNECTION_TIMEOUT';
      case DioExceptionType.sendTimeout:
        return 'SEND_TIMEOUT';
      case DioExceptionType.receiveTimeout:
        return 'RECEIVE_TIMEOUT';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 400) {
          final data = e.response?.data;
          if (data is Map && data['message'] != null) {
            return data['message'].toString();
          }
          return 'VALIDATION_ERROR';
        }
        if (code == 401) return 'UNAUTHORIZED';
        if (code == 403) return 'ACCESS_DENIED';
        if (code == 404) return 'NOT_FOUND';
        return 'BAD_RESPONSE';
      case DioExceptionType.cancel:
        return 'REQUEST_CANCELLED';
      case DioExceptionType.connectionError:
        return 'NO_INTERNET';
      default:
        return 'UNKNOWN_ERROR';
    }
  }
}
