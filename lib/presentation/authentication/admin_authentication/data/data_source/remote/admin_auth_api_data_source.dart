import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/remote/admin_auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart';
import 'package:dio/dio.dart';

class AdminAuthApiDataSource implements AdminAuthRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AdminAuthApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminLoginModel> adminLogin({
    required String accessKey,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.adminLoginEndPoint,
        data: {
          "adminKey": accessKey,
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return AdminLoginModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MeModel> getMe() async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.me,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return MeModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ValidateTokenModel> validateToken()async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.validateToken,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return ValidateTokenModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
