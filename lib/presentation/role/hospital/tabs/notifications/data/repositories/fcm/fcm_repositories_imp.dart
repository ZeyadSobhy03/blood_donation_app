import '../../data_source/fcm/fcm_remote_data_source.dart';
import '../../models/fcm/fcm_model.dart';
import 'fcm_repositories.dart';

class FcmRepositoriesImp implements FcmRepositories {
  final FcmRemoteDataSource fcmRemoteDataSource;

  FcmRepositoriesImp({required this.fcmRemoteDataSource});

  @override
  Future<FcmModel> saveFcmToken({
    required String token,
    required String accessToken,
  }) {
    return fcmRemoteDataSource.saveFcmToken(token: token, accessToken: accessToken);
  }
}
