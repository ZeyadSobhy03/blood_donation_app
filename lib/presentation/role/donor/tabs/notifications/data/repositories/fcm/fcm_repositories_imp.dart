import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/fcm/fcm_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/fcm/fcm_model.dart';

import 'fcm_repositories.dart';

class FcmRepositoriesImp  implements FcmRepositories{
  final FcmRemoteDataSource fcmRemoteDataSource;
  FcmRepositoriesImp({required this.fcmRemoteDataSource});
  @override
  Future<FcmModel> saveFcmToken(String token) {
    return fcmRemoteDataSource.saveFcmToken(token);
  }


}