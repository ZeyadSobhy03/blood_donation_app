import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/change_password/change_password_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/change_password/change_password_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class ChangePasswordApiDataSource implements ChangePasswordRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;

  ChangePasswordApiDataSource(this.dio, this.authHiveDataSource);

  @override
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final token = await authHiveDataSource.getAccessToken();

      final Map<String, dynamic> data = {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmNewPassword,
      };

      final response = await dio.post(
        ApiManger.changePasswordEndpoint,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return ChangePasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
