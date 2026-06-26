import '../../model/audit_logs/audit_logs_model.dart';

abstract class AuditLogsRepositories {
  Future<AuditLogsModel> getAuditLogs({
    required int page,
    required int limit,
    required String? targetType,
    required String? action,
  });
}