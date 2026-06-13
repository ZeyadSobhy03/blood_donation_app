import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_health_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_health_repositories.dart';

import '../data_source/remote/system_health_remote_data_source.dart';

class SystemHealthRepositoriesImp implements SystemHealthRepositories {
  final SystemHealthRemoteDataSource systemHealthRemoteDataSource;

  SystemHealthRepositoriesImp({required this.systemHealthRemoteDataSource});
  @override
  Future<SystemHealthModel> getSystemHealth() {
    return systemHealthRemoteDataSource.getSystemHealth();
  }


}
