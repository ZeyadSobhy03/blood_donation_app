import 'dart:developer';

import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/resources/models/create_hospital_model.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/ban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/unban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';

class UsersApiDataSource implements UsersRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  UsersApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<UsersModel> getUsers({
    required int page,
    required int limit,
    String? role,
    String? search,
  }) async {
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
        },
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
  Future<DeleteUserModel> deleteUser({required String userId}) async {
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

  @override
  Future<BanUserModel> banUser({
    required String userId,
    required String reason,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.banUserEndpoint(userId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'reason': reason},
      );
      return BanUserModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UnbanUserModel> unbanUser({required String userId}) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.unbanUserEndpoint(userId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UnbanUserModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HospitalModel> createHospital({
    required CreateHospitalModel createHospitalModel,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.createHospitalEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: createHospitalModel.toJson(),
      );
      return HospitalModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdminModel> createAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final logData = {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
        'accessLevel':'Full Access'
      };
      log('Creating admin with data: $logData');
      final response = await dio.post(
        ApiManger.createAdminEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'phone': phone,
          'role': role,
        },
      );

      return AdminModel.fromJson(response.data);
    } on DioException catch (e) {
      log('createAdmin DioException: ${e.response}');
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
