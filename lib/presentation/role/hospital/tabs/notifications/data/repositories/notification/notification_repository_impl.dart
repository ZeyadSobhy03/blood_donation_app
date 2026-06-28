import '../../models/notification/notifications_model.dart';
import '../../repositories/notification/notification_repository.dart';
import '../../data_source/notification/local/notification_hive_data_source.dart';
import '../../data_source/notification/remote/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final LocalNotificationDataSource localDataSource;

  NotificationRepositoryImpl({
    required this.notificationRemoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<NotificationsModel> getNotifications({
    required int page,
    required int limit,
    required String accessToken,
  }) async {
    try {
      final remoteData = await notificationRemoteDataSource.getNotifications(
        page: page,
        limit: limit,
        accessToken: accessToken,
      );
      await localDataSource.saveNotifications(remoteData);
      return remoteData;
    } catch (e) {
      final cachedData = await localDataSource.getNotifications();
      if (cachedData != null) {
        return cachedData;
      }
      rethrow;
    }
  }

  @override
  Future<NotificationsModel> markAllAsRead({required String accessToken}) {
    return notificationRemoteDataSource.markAllAsRead(accessToken: accessToken);
  }

  @override
  Future<void> deleteAllNotifications({required String accessToken}) {
    return notificationRemoteDataSource.deleteAllNotifications(accessToken: accessToken);
  }
}
