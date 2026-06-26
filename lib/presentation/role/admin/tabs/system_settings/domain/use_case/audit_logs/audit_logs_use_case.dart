import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/audit_logs/audit_logs_repositories.dart';

import '../../../data/model/audit_logs/audit_logs_model.dart';

class AuditLogsUseCase {
  final AuditLogsRepositories auditLogsRepositories;
  AuditLogsUseCase({required this.auditLogsRepositories});
  Future<AuditLogsModel> getAuditLogs({
    required int page,
    required int limit,
    required String? targetType,
    required String? action,
  }) {
    return auditLogsRepositories.getAuditLogs(
      page: page,
      limit: limit,
      targetType: targetType,
      action: action,
    );
  }
}