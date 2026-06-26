import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/profile/admin_profile_repositories.dart';

import '../../../data/model/profile/admin_profile_model.dart';
import '../../../data/model/profile/admin_profile_update_model.dart';

class AdminProfileUseCase {

  final AdminProfileRepositories profileRepositories;
  AdminProfileUseCase({required this.profileRepositories});
  Future<AdminProfileModel> getProfile() async {
    return await profileRepositories.getProfile();
  }
  Future<AdminProfileUpdateModel> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  }){
    return profileRepositories.updateProfile(
      fullName: fullName,
      email: email,
      phone: phone,
    );
  }
}