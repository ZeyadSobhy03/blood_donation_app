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
    await _box.put(_key, model.toJson());
  }

  @override
  Future<NotificationsModel?> getNotifications() async {
    final data = _box.get(_key);
    if (data == null) return null;
    return NotificationsModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<void> clearNotifications() async {
    await _box.delete(_key);
  }
}