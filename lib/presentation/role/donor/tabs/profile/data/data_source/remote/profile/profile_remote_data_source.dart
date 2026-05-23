import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/profile/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel>getProfile();
}