import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_health/system_health_repositories.dart';

import '../../../data/model/system_health/system_health_model.dart';

class SystemHealthUseCase {
  final SystemHealthRepositories systemHealthRepositories;
  SystemHealthUseCase({required this.systemHealthRepositories});
  Future<SystemHealthModel>getSystemHealth(){
    return systemHealthRepositories.getSystemHealth();
  }

}