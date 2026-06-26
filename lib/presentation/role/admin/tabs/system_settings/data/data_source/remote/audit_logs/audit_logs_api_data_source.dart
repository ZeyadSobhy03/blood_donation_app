import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/audit_logs/audit_logs_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/audit_logs/audit_logs_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';

class AuditLogsApiDataSource implements AuditLogsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;
  AuditLogsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AuditLogsModel> getAuditLogs({required int page, required int limit, required String? targetType, required String? action})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminAuditLogsEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (targetType != null) 'targetType': targetType,
          if (action != null) 'action': action,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AuditLogsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }


  }

}