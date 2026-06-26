import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/maintenance_status_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/system_maintenance_model.dart';

abstract class SystemMaintenanceRemoteDataSource {
  Future<SystemMaintenanceModel> toggleSystemMaintenance({
    required bool enabled,
    required String message,
  });
  Future<MaintenanceStatusModel> getMaintenanceStatus();
}
