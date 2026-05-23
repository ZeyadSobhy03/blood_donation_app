import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/fcm/fcm_model.dart';

abstract class FcmRemoteDataSource {
  Future<FcmModel> saveFcmToken(String token);
}