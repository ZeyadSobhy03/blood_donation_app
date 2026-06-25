import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:dio/dio.dart';

import '../models/home_dashboard_model.dart';
import '../models/home_activity_model.dart';
import '../models/home_requests_model.dart';
import '../models/home_request_detail_model.dart';
import '../models/home_request_responses_model.dart';
import '../models/home_nearby_donors_model.dart';
import '../models/home_update_request_model.dart';
import 'home_remote_data_source.dart';

class HomeApiDataSource implements HomeRemoteDataSource {
  final Dio dio;

  HomeApiDataSource(this.dio);

  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> _authHeaders(String token) => {
    ..._jsonHeaders,
    'Authorization': 'Bearer $token',
  };

  @override
  Future<HomeDashboardModel> getDashboard({required String token}) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalDashboardEndpoint,
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeDashboardModel.fromJson(response.data);
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
  Future<HomeActivityModel> getActivity({required String token}) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalActivityEndpoint,
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeActivityModel.fromJson(response.data);
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
  Future<HomeRequestsModel> getRequests({
    required String token,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalRequestsEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeRequestsModel.fromJson(response.data);
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
  Future<HomeRequestDetailModel> getRequestDetail({
    required String token,
    required String requestId,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalRequestByIdEndpoint(requestId),
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeRequestDetailModel.fromJson(response.data);
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
  Future<HomeUpdateRequestModel> updateRequestStatus({
    required String token,
    required String requestId,
    required String status,
  }) async {
    try {
      final response = await dio.put(
        ApiManger.hospitalRequestByIdEndpoint(requestId),
        data: {'status': status},
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeUpdateRequestModel.fromJson(response.data);
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
  Future<HomeUpdateRequestModel> updateRequest({
    required String token,
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
      final response = await dio.put(
        ApiManger.hospitalRequestByIdEndpoint(requestId),
        data: {
          'status': status,
          'bloodTypes': bloodTypes,
          'urgency': urgency,
          'unitsNeeded': unitsNeeded,
          'requiredBy': requiredBy,
          'patientType': patientType,
          'contactNumber': contactNumber,
          'patientDetails': patientDetails,
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeUpdateRequestModel.fromJson(response.data);
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
  Future<void> cancelRequest({
    required String token,
    required String requestId,
  }) async {
    try {
      final response = await dio.delete(
        ApiManger.hospitalRequestByIdEndpoint(requestId),
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
  Future<HomeRequestResponsesModel> getRequestResponses({
    required String token,
    required String requestId,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalRequestResponsesEndpoint(requestId),
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeRequestResponsesModel.fromJson(response.data);
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
  Future<HomeNearbyDonorsModel> getNearbyDonorGroups({
    required String token,
    double? lat,
    double? lng,
    double radiusKm = 5,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.hospitalNearbyDonorsEndpoint,
        queryParameters: {
          if (lat != null) 'lat': lat,
          if (lng != null) 'lng': lng,
          'radiusKm': radiusKm,
          'groupBy': 'bloodType',
        },
        options: Options(headers: _authHeaders(token)),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return HomeNearbyDonorsModel.fromJson(response.data);
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
