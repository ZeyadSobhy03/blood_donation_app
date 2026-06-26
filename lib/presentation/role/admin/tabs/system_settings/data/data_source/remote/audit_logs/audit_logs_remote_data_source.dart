import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/audit_logs/audit_logs_model.dart';

abstract class AuditLogsRemoteDataSource {
  Future<AuditLogsModel> getAuditLogs({
    required int page,
    required int limit,
    required String? targetType,
    required String? action,
  });
}