import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/setting/setting_repositories.dart';

import '../../../data/model/setting/setting_model.dart';

class SettingUseCase {
  final SettingRepositories settingRepositories;

  SettingUseCase({required this.settingRepositories});

  Future<SettingModel> getSetting() async {
    return await settingRepositories.getSetting();
  }

  Future<SettingModel> updateSetting({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool privacyMode,
    required String language,
  }) async {
    return await settingRepositories.updateSetting(
      pushNotifications: pushNotifications,
      emergencyAlerts: emergencyAlerts,
      privacyMode: privacyMode,
      language: language,
    );
  }
}
