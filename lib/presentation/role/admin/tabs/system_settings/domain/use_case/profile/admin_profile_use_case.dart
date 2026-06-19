import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/profile/admin_profile_repositories.dart';

import '../../../data/model/profile/admin_profile_model.dart';

class AdminProfileUseCase {

  final AdminProfileRepositories profileRepositories;
  AdminProfileUseCase({required this.profileRepositories});
  Future<AdminProfileModel> getProfile() async {
    return await profileRepositories.getProfile();
  }
}