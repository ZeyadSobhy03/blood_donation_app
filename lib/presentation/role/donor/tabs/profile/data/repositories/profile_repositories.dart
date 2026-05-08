import '../model/profile_model.dart';

abstract class ProfileRepositories {
  Future<ProfileModel>getProfile();

}