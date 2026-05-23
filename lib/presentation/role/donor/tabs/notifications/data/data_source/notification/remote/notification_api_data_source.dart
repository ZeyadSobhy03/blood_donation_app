import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/notification/remote/notification_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart';
import 'package:dio/dio.dart';
import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class NotificationApiDataSource implements NotificationRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  NotificationApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<NotificationsModel> getNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.notificationsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'page': page, 'limit': limit},
      );

      return NotificationsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<NotificationsModel> markAsAllAsRead() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.markAllNotificationsAsReadEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return NotificationsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteNotifications() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      await dio.delete(
        ApiManger.deleteNotificationEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
