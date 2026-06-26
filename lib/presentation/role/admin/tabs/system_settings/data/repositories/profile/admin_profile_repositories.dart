import '../../model/profile/admin_profile_model.dart';
import '../../model/profile/admin_profile_update_model.dart';

abstract class AdminProfileRepositories {

  Future<AdminProfileModel> getProfile();
  Future<AdminProfileUpdateModel> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  });

}