import '../../../data/models/notification/notifications_model.dart';
import '../../../data/repositories/notification/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository repository;
  NotificationUseCase({required this.repository});

  Future<NotificationsModel> getNotifications({
    required int page,
    required int limit,
    required String accessToken,
  }) {
    return repository.getNotifications(page: page, limit: limit, accessToken: accessToken);
  }

  Future<NotificationsModel> markAllAsRead({required String accessToken}) {
    return repository.markAllAsRead(accessToken: accessToken);
  }

  Future<void> deleteAllNotifications({required String accessToken}) {
    return repository.deleteAllNotifications(accessToken: accessToken);
  }
}
