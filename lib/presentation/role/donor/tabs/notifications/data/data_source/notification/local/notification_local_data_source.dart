// ===== HIVE NOTIFICATION DATA SOURCE (hive_notification_data_source.dart) =====

import 'package:hive_ce/hive.dart';
import '../../../models/notification/notifications_model.dart';
import 'notification_hive_data_source.dart';

class HiveNotificationDataSource implements LocalNotificationDataSource {
  static const String _boxName = 'notifications_box';
  static const String _key = 'notifications';

  late Box _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> saveNotifications(NotificationsModel model) async {
    try {
      await _box.put(_key, model.toJson());
    } catch (e) {
      print('Error saving notifications to Hive: $e');
    }
  }

  @override
  Future<NotificationsModel?> getNotifications() async {
    try {
      final data = _box.get(_key);
      if (data == null) return null;
      return NotificationsModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      print('Error getting notifications from Hive: $e');
      return null;
    }
  }

  @override
  Future<void> clearNotifications() async {
    try {
      await _box.delete(_key);
    } catch (e) {
      print('Error clearing notifications from Hive: $e');
    }
  }

  @override
  Future<void> appendNotifications(NotificationsModel model) async {
    try {
      final existingData = await getNotifications();

      if (existingData != null &&
          existingData.data != null &&
          existingData.data!.notifications != null) {

        // Merge notifications from existing and new model
        final allNotifications = [
          ...existingData.data!.notifications!,
          ...?model.data?.notifications,
        ];

        // Remove duplicates by ID
        final Map<String, Notifications> uniqueMap = {};
        for (var notification in allNotifications) {
          final id = notification.id;
          if (id != null) {
            uniqueMap[id] = notification;
          }
        }

        final uniqueNotifications = uniqueMap.values.toList();

        // Create new Data object with merged notifications
        final updatedData = Data(
          notifications: uniqueNotifications,
          unreadCount: model.data?.unreadCount ??
              existingData.data?.unreadCount ?? 0,
          pagination: model.data?.pagination,
        );

        final updatedModel = NotificationsModel(
          success: existingData.success,
          message: existingData.message,
          data: updatedData,
        );

        // Save updated model to Hive
        await _box.put(_key, updatedModel.toJson());
      } else {
        // If no existing data, just save the new model
        await _box.put(_key, model.toJson());
      }
    } catch (e) {
      print('Error appending notifications to Hive: $e');
      // Fallback: save the new model
      await _box.put(_key, model.toJson());
    }
  }
}