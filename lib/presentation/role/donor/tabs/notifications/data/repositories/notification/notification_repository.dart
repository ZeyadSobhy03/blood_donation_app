
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart';

abstract class NotificationRepository {
  Future<NotificationsModel > getNotifications({required int page ,required int limit });
  Future<NotificationsModel>markAsAllAsRead();
  Future<void>deleteNotifications();

}