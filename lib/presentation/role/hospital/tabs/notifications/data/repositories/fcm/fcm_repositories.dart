import '../../models/fcm/fcm_model.dart';

abstract class FcmRepositories {
  Future<FcmModel> saveFcmToken({required String token, required String accessToken});
}
