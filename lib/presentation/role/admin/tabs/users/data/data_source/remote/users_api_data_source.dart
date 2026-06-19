import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';

class UsersApiDataSource implements UsersRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  UsersApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<UsersModel> getUsers(
  {
    required int page ,
    required int limit ,
     String? role,
     String? search,

}
      ) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminUsersEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
          queryParameters: {
          'page': page,
          'limit': limit,
          'role': role,
          'search': search,
        }
      );
      return UsersModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteUserModel> deleteUser({required String userId}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.delete(
        ApiManger.deleteUserEndpoint(userId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return DeleteUserModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
