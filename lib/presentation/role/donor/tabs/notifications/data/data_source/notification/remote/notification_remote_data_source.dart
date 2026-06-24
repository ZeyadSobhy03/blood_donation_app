
import '../../../models/notification/notifications_model.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationsModel >getNotifications({required int page,required int limit });
  Future<NotificationsModel>markAsAllAsRead();
  Future<void>deleteNotifications();
}
