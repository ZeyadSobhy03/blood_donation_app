import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/repositories/notification/notification_repository.dart';

import '../../data_source/notification/local/notification_hive_data_source.dart';
import '../../data_source/notification/remote/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements  NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;
  final LocalNotificationDataSource localDataSource;
  NotificationRepositoryImpl({required this.notificationRemoteDataSource, required this.localDataSource});
  @override
  Future<NotificationsModel> getNotifications() async {
    try {
      final remoteData = await notificationRemoteDataSource.getNotifications();
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
  Future<NotificationsModel> markAsAllAsRead() {
    return notificationRemoteDataSource.markAsAllAsRead();
  }

  @override
  Future<void> deleteNotifications() {
    return notificationRemoteDataSource.deleteNotifications();
  }

}