import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/maintenance_status_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/system_maintenance_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_maintenance/system_maintenance_repositories.dart';

import '../../data_source/remote/system_maintenance/system_maintenance_remote_data_source.dart';

class SystemMaintenanceRepositoriesImp implements SystemMaintenanceRepositories {
  final SystemMaintenanceRemoteDataSource systemMaintenanceRemoteDataSource;
  SystemMaintenanceRepositoriesImp({
    required this.systemMaintenanceRemoteDataSource,
  });
  @override
  Future<SystemMaintenanceModel> toggleSystemMaintenance({required bool enabled, required String message}) {
    return systemMaintenanceRemoteDataSource.toggleSystemMaintenance(enabled: enabled, message: message);
  }

  @override
  Future<MaintenanceStatusModel> getMaintenanceStatus() {
    return systemMaintenanceRemoteDataSource.getMaintenanceStatus();
  }



}