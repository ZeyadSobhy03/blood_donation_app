import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/system_maintenance/system_maintenance_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/maintenance_status_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/system_maintenance_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../../../core/utils/dio_error_handler.dart';

class SystemMaintenanceApiDataSource
    implements SystemMaintenanceRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  SystemMaintenanceApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<SystemMaintenanceModel> toggleSystemMaintenance({
    required bool enabled,
    required String message,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.systemMaintenanceEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {'enabled': enabled, 'message': message},
      );
      return SystemMaintenanceModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MaintenanceStatusModel> getMaintenanceStatus() async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.systemMaintenanceEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token' ,
          },
      ),
      );
      return MaintenanceStatusModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
