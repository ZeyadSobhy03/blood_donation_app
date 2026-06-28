import '../../../data/models/fcm/fcm_model.dart';
import '../../../data/repositories/fcm/fcm_repositories.dart';

class FcmUseCase {
  final FcmRepositories repository;
  FcmUseCase({required this.repository});

  Future<FcmModel> saveFcmToken({
    required String token,
    required String accessToken,
  }) {
    return repository.saveFcmToken(token: token, accessToken: accessToken);
  }
}
