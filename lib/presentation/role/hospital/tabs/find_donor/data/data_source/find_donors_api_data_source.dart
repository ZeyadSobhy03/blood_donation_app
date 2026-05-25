import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/data_source/find_donors_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/model/find_donors_model.dart';
import 'package:dio/dio.dart';

class FindDonorsApiDataSource implements FindDonorsRemoteDataSource {
  final Dio dio;

  FindDonorsApiDataSource(this.dio);

  @override
  Future<FindDonorsModel> findDonors({
    required String token,
    String? bloodType,
    double? radiusKm,
    double? lat,
    double? lng,
    bool availability = true,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'availability': availability,
        'page': page,
        'limit': limit,
        if (bloodType != null && bloodType.isNotEmpty) 'bloodType': bloodType,
        if (radiusKm != null) 'radiusKm': radiusKm,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      };

      final response = await dio.get(
        ApiManger.hospitalFindDonorsEndpoint,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (_isSuccess(response.statusCode)) {
        if (response.data == null) throw Exception('EMPTY_RESPONSE');
        return FindDonorsModel.fromJson(response.data);
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
        if (code == 401) return 'UNAUTHORIZED';       // missing/invalid JWT
        if (code == 403) return 'ACCESS_DENIED';      // role not allowed
        if (code == 404) return 'HOSPITAL_NOT_FOUND'; // coordinate fallback failed
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