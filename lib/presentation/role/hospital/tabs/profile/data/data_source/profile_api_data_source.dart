import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/data_source/profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:dio/dio.dart';

class ProfileApiDataSource implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileApiDataSource(this.dio);

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._jsonHeaders,
    'Authorization': 'Bearer $token',
  };

  @override
  Future<HospitalProfileModel> getProfile({required String token}) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalProfileEndpoint,
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HospitalProfileModel.fromJson(response.data);
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
  Future<void> updateProfile({
    required String token,
    required String hospitalName,
    required String department,
    required String contactNumber,
    required String email,
    required String address,
    double? lat,
    double? lng,
  }) async {
    try {
      final response = await dio.put(
        ApiManger.hospitalProfileEndpoint,
        data: {
          'hospitalName': hospitalName,
          'department': department,
          'contactNumber': contactNumber,
          'email': email,
          'address': address,
          if (lat != null) 'lat': lat,
          if (lng != null) 'lng': lng,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        return;
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
  Future<void> updateWorkingHours({
    required String token,
    required int workingHoursStart,
    required int workingHoursEnd,
    required int slotsPerHour,
  }) async {
    try {
      final response = await dio.put(
        ApiManger.hospitalProfileEndpoint,
        data: {
          'workingHoursStart': workingHoursStart,
          'workingHoursEnd': workingHoursEnd,
          'slotsPerHour': slotsPerHour,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        return;
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
  Future<void> updateNotificationPreferences({
    required String token,
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  }) async {
    try {
      final response = await dio.put(
        ApiManger.hospitalProfileEndpoint,
        data: {
          'pushNotifications': pushNotifications,
          'emergencyAlerts': emergencyAlerts,
          'emailNotifications': emailNotifications,
          'smsAlerts': smsAlerts,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        return;
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
  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.put(
        ApiManger.hospitalChangePasswordEndpoint,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        return;
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
