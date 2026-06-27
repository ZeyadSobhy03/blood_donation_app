import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/log_out_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/log_out/admin_log_out_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../../../core/utils/dio_error_handler.dart';

class AdminLogOutApiDataSource implements AdminLogOutRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;
  AdminLogOutApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    try {
      return dio
          .post(
        ApiManger.logoutEndpoint,
        data: {"refreshToken": refreshToken, "fcmToken": fcmToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      )
          .then((response) => LogOutModel.fromJson(response.data));
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}