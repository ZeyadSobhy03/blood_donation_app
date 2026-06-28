import '../../models/fcm/fcm_model.dart';

abstract class FcmRemoteDataSource {
  Future<FcmModel> saveFcmToken({required String token, required String accessToken});
}
