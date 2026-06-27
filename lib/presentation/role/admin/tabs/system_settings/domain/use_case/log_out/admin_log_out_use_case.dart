import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/log_out/admin_log_out_repositories.dart';

import '../../../../../../../authentication/donor_authentication/data/model/log_out_model.dart';

class AdminLogOutUseCase {
  final AdminLogOutRepositories logOutRepositories;
  AdminLogOutUseCase({required this.logOutRepositories});
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    return logOutRepositories.logOut(refreshToken: refreshToken, fcmToken: fcmToken);
  }
}