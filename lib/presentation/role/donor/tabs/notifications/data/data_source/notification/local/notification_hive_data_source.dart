
import '../../../models/notification/notifications_model.dart';

abstract class LocalNotificationDataSource {
  Future<void> init();

  Future<void> saveNotifications(NotificationsModel model);

  Future<NotificationsModel?> getNotifications();

  Future<void> clearNotifications();

  Future<void> appendNotifications(NotificationsModel model);
}