import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/data_source/request_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_model.dart';
import 'package:dio/dio.dart';

class RequestApiDataSource implements RequestRemoteDataSource {
  final Dio dio;

  RequestApiDataSource(this.dio);

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  @override
  Future<RequestModel> createRequest({
    required String token,
    required List<String> bloodTypes,
    required String urgency,
    required String requiredBy,
    required int unitsNeeded,
    required String patientType,
    required String contactNumber,
    required String patientDetails,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.hospitalCreateRequestEndpoint,
        data: {
          'type': 'blood',
          'bloodType': bloodTypes,
          'urgency': urgency,
          'requiredBy': requiredBy,
          'quantity': unitsNeeded,
          'unitsNeeded': unitsNeeded,
          'patientType': patientType,
          'contactNumber': contactNumber,
          'isEmergency': false,
          'patientDetails': patientDetails,
          'status': 'pending',
        },
        options: Options(
          headers: {
            ..._jsonHeaders,
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return RequestModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }


  @override
  Future<RequestModel> createEmergencyRequest({
    required String token,
    required String bloodType,
    required int unitsNeeded,
    required String patientDetails,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.hospitalCreateEmergencyRequestEndpoint,
        data: {
          'bloodType': bloodType,
          'unitsNeeded': unitsNeeded,
          'patientDetails': patientDetails,
        },
        options: Options(
          headers: {
            ..._jsonHeaders,
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return RequestModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
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