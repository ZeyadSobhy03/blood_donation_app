import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/fcm/fcm_model.dart';

abstract class FcmRepositories {
  Future<FcmModel> saveFcmToken(String token);
}