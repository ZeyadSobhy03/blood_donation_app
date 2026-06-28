import 'package:dio/dio.dart';

import '../../models/fcm/fcm_model.dart';
import 'fcm_remote_data_source.dart';
import '../../../../../../../../core/resources/api_manger/api_constants.dart';

class FcmApiDataSource implements FcmRemoteDataSource {
  final Dio dio;

  FcmApiDataSource(this.dio);

  @override
  Future<FcmModel> saveFcmToken({
    required String token,
    required String accessToken,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.saveFcmTokenEndpoint,
        data: {'fcmToken': token},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return FcmModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'CONNECTION_TIMEOUT';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 401) return 'UNAUTHORIZED';
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
