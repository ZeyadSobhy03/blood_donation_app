
import '../../../models/notification/notifications_model.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationsModel >getNotifications({int page = 1, int limit = 10});
  Future<NotificationsModel>markAsAllAsRead();
  Future<void>deleteNotifications();
}
