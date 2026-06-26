import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/audit_logs/audit_logs_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/audit_logs/audit_logs_repositories.dart';

import '../../data_source/remote/audit_logs/audit_logs_remote_data_source.dart';

class AuditLogsRepositoriesImp implements AuditLogsRepositories {
  final AuditLogsRemoteDataSource auditLogsRemoteDataSource;
  AuditLogsRepositoriesImp({
    required this.auditLogsRemoteDataSource,
  });

  @override
  Future<AuditLogsModel> getAuditLogs({required int page, required int limit, required String? targetType, required String? action}) {
    return auditLogsRemoteDataSource.getAuditLogs(page: page, limit: limit, targetType: targetType, action: action);
  }

}