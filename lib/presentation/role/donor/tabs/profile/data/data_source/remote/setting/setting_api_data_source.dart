import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/setting/setting_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/setting/setting_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class SettingApiDataSource implements SettingRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;
  SettingApiDataSource(this.dio,this.authHiveDataSource);

  @override
  Future<SettingModel> getSetting() async{
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.getSettingEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return SettingModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<SettingModel> updateSetting({required bool pushNotifications, required bool emergencyAlerts, required bool privacyMode, required String language})async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.put(
        ApiManger.getSettingEndpoint,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          "pushNotifications": pushNotifications,
          "emergencyAlerts": emergencyAlerts,
          "privacyMode": privacyMode,
          "language": language,
        },
      );
      return SettingModel.fromJson(response.data);
    }on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }


}