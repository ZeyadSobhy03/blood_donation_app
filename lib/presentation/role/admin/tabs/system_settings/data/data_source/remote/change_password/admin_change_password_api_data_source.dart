import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/change_password/admin_change_password_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import '../../../model/admin_change_password/admin_change_password_model.dart';

class AdminChangePasswordApiDataSource implements AdminChangePasswordRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;
  AdminChangePasswordApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminChangePasswordModel> changePassword({required String currentPassword, required String newPassword, required String confirmNewPassword}) async{

    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.changePasswordEndpoint,
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AdminChangePasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow ;
    } catch (e) {
      rethrow;
    }

  }

}