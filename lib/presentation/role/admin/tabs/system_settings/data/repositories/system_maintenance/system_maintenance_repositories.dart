import '../../model/system_maintenance/maintenance_status_model.dart';
import '../../model/system_maintenance/system_maintenance_model.dart';

abstract class SystemMaintenanceRepositories {

  Future<SystemMaintenanceModel> toggleSystemMaintenance({
    required bool enabled,
    required String message,
  });
  Future<MaintenanceStatusModel> getMaintenanceStatus();

}
