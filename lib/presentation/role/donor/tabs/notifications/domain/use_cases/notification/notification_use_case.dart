
import '../../../data/models/notification/notifications_model.dart';
import '../../../data/repositories/notification/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository repository;
  NotificationUseCase({required this.repository});
  Future<NotificationsModel> getNotifications(){
    return repository.getNotifications();

  }
  Future<NotificationsModel>markAsAllAsRead(){
    return repository.markAsAllAsRead();
  }
  Future<void>deleteNotifications(){
    return repository.deleteNotifications();
  }



}