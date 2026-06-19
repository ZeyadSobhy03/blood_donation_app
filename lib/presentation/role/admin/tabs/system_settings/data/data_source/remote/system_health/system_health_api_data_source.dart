import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/system_health/system_health_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_health/system_health_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class SystemHealthApiDataSource implements SystemHealthRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  SystemHealthApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<SystemHealthModel> getSystemHealth() async {
    try {
      final token = adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.systemHealthEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return SystemHealthModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
