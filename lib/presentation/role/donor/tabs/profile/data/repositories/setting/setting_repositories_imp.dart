import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/setting/setting_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/setting/setting_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/setting/setting_repositories.dart';

class SettingRepositoriesImp implements SettingRepositories {
  final SettingRemoteDataSource settingRemoteDataSource;
  SettingRepositoriesImp({required this.settingRemoteDataSource});

  @override
  Future<SettingModel> getSetting() {
    return settingRemoteDataSource.getSetting();
  }

  @override
  Future<SettingModel> updateSetting({required bool pushNotifications, required bool emergencyAlerts, required bool privacyMode, required String language}) {
    return settingRemoteDataSource.updateSetting(pushNotifications: pushNotifications, emergencyAlerts: emergencyAlerts, privacyMode: privacyMode, language: language);
  }


}