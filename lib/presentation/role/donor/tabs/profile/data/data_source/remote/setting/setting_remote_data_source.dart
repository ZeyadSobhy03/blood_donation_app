import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/setting/setting_model.dart';

abstract class SettingRemoteDataSource {
  Future<SettingModel> getSetting();

  Future<SettingModel> updateSetting({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool privacyMode,
    required String language,
  });
}
