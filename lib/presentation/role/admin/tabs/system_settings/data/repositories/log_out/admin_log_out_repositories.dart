import '../../../../../../../authentication/donor_authentication/data/model/log_out_model.dart';

abstract class AdminLogOutRepositories {
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  });
}