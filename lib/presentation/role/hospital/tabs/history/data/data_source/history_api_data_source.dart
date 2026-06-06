import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/data_source/history_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';
import 'package:dio/dio.dart';

class HistoryApiDataSource implements HistoryRemoteDataSource {
  final Dio dio;

  HistoryApiDataSource(this.dio);

  @override
  Future<HistoryModel> getHistory({
    required String token,
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (status != null && status.isNotEmpty) 'status': status,
      };

      final response = await dio.get(
        ApiManger.hospitalHistoryEndpoint,
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
        return HistoryModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      print('HistoryApiDataSource raw error: ${e.runtimeType}: $e');
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
        if (code == 400) return 'INVALID_STATUS_FILTER';
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