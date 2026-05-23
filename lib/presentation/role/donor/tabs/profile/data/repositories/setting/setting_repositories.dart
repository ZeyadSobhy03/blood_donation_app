
import '../../model/setting/setting_model.dart';

abstract class SettingRepositories {

  Future<SettingModel>getSetting();
  Future<SettingModel> updateSetting({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool privacyMode,
    required String language,
  });

}