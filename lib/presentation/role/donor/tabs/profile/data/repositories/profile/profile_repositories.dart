import '../../model/profile/profile_model.dart';

abstract class ProfileRepositories {
  Future<ProfileModel>getProfile();

}