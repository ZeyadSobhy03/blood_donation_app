import '../../../models/notification/notifications_model.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationsModel> getNotifications({
    required int page,
    required int limit,
    required String accessToken,
  });

  Future<NotificationsModel> markAllAsRead({required String accessToken});

  Future<void> deleteAllNotifications({required String accessToken});
}
