import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/fcm/fcm_model.dart';

import '../../../data/repositories/fcm/fcm_repositories.dart';

class FcmUseCase {
  final FcmRepositories repository;
  FcmUseCase({required this.repository});
  Future<FcmModel> saveFcmToken(String token){
    return repository.saveFcmToken(token);
  }
}