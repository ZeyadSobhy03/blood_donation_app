import '../../../../../../../../authentication/donor_authentication/data/model/log_out_model.dart';

abstract class AdminLogOutRemoteDataSource {
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  });

}