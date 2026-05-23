
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart';

abstract class NotificationRepository {
  Future<NotificationsModel > getNotifications();
  Future<NotificationsModel>markAsAllAsRead();
  Future<void>deleteNotifications();

}