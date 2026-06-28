import 'package:dio/dio.dart';

import '../../../models/notification/notifications_model.dart';
import 'notification_remote_data_source.dart';
import '../../../../../../../../../core/resources/api_manger/api_constants.dart';

class NotificationApiDataSource implements NotificationRemoteDataSource {
  final Dio dio;

  NotificationApiDataSource(this.dio);

  @override
  Future<NotificationsModel> getNotifications({
    required int page,
    required int limit,
    required String accessToken,
  }) async {
    try {
      final response = await dio.get(
        ApiManger.notificationsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
        queryParameters: {'page': page, 'limit': limit},
      );
      return NotificationsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }

  @override
  Future<NotificationsModel> markAllAsRead({required String accessToken}) async {
    try {
      final response = await dio.patch(
        ApiManger.markAllNotificationsAsReadEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return NotificationsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      if (e.toString().contains('Exception')) rethrow;
      throw Exception('UNKNOWN_ERROR');
    }
  }

  @override
  Future<void> deleteAllNotifications({required String accessToken}) async {
    try {
      await dio.delete(
        ApiManger.deleteNotificationEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
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
        final data = e.response?.data;
        if (data is Map && data['message'] != null) return data['message'].toString();
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
