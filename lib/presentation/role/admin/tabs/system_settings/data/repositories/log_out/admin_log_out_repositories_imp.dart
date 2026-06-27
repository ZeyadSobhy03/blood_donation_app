import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/log_out/admin_log_out_repositories.dart';

import '../../../../../../../authentication/donor_authentication/data/model/log_out_model.dart';
import '../../data_source/remote/log_out/admin_log_out_remote_data_source.dart';

class AdminLogOutRepositoriesImp implements AdminLogOutRepositories {
  final AdminLogOutRemoteDataSource remoteDataSource;
  AdminLogOutRepositoriesImp({required this.remoteDataSource});

  @override
  Future<LogOutModel> logOut({required String refreshToken, required String fcmToken}) {
    return remoteDataSource.logOut(refreshToken: refreshToken, fcmToken: fcmToken);
  }
}