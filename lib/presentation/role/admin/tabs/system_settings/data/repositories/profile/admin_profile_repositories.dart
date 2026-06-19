import '../../model/profile/admin_profile_model.dart';

abstract class AdminProfileRepositories {

  Future<AdminProfileModel> getProfile();

}