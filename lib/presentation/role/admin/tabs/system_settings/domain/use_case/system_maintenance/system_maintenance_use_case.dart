import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_maintenance/system_maintenance_repositories.dart';

import '../../../data/model/system_maintenance/maintenance_status_model.dart';
import '../../../data/model/system_maintenance/system_maintenance_model.dart';

class SystemMaintenanceUseCase {
  final SystemMaintenanceRepositories systemMaintenanceRepositories;
  SystemMaintenanceUseCase({required this.systemMaintenanceRepositories});

  Future<SystemMaintenanceModel> toggleSystemMaintenance({
    required bool enabled,
    required String message,
  }){
    return systemMaintenanceRepositories.toggleSystemMaintenance(
      enabled: enabled,
      message: message,
    );
  }
  Future<MaintenanceStatusModel> getMaintenanceStatus(){
    return systemMaintenanceRepositories.getMaintenanceStatus();
  }
}