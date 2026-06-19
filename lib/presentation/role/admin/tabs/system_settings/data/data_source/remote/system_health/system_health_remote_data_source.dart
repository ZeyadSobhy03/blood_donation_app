import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_health/system_health_model.dart';

abstract class SystemHealthRemoteDataSource {

  Future<SystemHealthModel>getSystemHealth();

}