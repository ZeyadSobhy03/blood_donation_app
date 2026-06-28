import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/remote_data_source/hospital_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:dio/dio.dart';

class HospitalApiDataSource implements HospitalRemoteDataSource {
  final Dio dio;

  HospitalApiDataSource(this.dio);

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  @override
  Future<HospitalLoginModel> login({
    required String hospitalId,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.hospitalLoginEndpoint,
        data: {
          'hospitalId': hospitalId,
          'email': email,
          'password': password,
        },
        options: Options(headers: _jsonHeaders),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HospitalLoginModel.fromJson(response.data);
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
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        ApiManger.forgetPasswordEndpoint,
        data: {'email': email},
        options: Options(headers: _jsonHeaders),
      );

      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }

  @override
  Future<void> logOut({
    required String refreshToken,
    required String fcmToken,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.logoutEndpoint,
        data: {
          'refreshToken': refreshToken,
          'fcmToken': fcmToken,
        },
        options: Options(headers: _jsonHeaders),
      );

      if (!_isSuccess(response.statusCode)) {
        throw Exception(_extractServerError(response));
      }
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }


  bool _isSuccess(int? statusCode) =>
      statusCode != null && statusCode >= 200 && statusCode < 300;

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
        final statusCode = e.response?.statusCode;
        if (statusCode == 403) return 'HOSPITAL_NOT_APPROVED';
        final data = e.response?.data;
        if (data is Map && data['message'] != null) return data['message'] as String;
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