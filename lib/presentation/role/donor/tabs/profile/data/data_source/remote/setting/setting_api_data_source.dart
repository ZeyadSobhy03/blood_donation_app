import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/setting/setting_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/setting/setting_model.dart';
import 'package:dio/dio.dart';

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
      _handleDioError(e);
      rethrow;
    }
  }
  void _handleDioError(DioException e) {
    final _ = switch (e.type) {
      DioExceptionType.connectionTimeout =>
      'Connection timeout - please check your internet',
      DioExceptionType.sendTimeout => 'Send timeout - please try again',
      DioExceptionType.receiveTimeout => 'Receive timeout - please try again',
      DioExceptionType.badResponse => 'Server error: ${e.response?.statusCode}',
      DioExceptionType.cancel => 'Request cancelled',
      DioExceptionType.unknown => 'Network error: ${e.message}',
      _ => 'Unknown error occurred',
    };
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
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }


}