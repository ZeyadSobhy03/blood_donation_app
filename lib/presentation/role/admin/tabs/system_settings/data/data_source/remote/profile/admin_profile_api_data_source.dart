import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/profile/admin_profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_update_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class AdminProfileApiDataSource implements AdminProfileRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AdminProfileApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminProfileModel> getProfile() async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminProfileEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return AdminProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdminProfileUpdateModel> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.updateAdminProfileEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {'name': fullName, 'email': email, 'phone': phone},
      );
      return AdminProfileUpdateModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
