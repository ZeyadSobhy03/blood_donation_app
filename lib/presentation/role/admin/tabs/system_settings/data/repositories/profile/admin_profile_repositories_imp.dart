import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/profile/admin_profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_update_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/profile/admin_profile_repositories.dart';


class AdminProfileRepositoriesImp implements AdminProfileRepositories {

  final AdminProfileRemoteDataSource profileRemoteDataSource;
  AdminProfileRepositoriesImp({
    required this.profileRemoteDataSource,
  });

  @override
  Future<AdminProfileModel> getProfile() {
    return profileRemoteDataSource.getProfile();
  }

  @override
  Future<AdminProfileUpdateModel> updateProfile({required String fullName, required String email, required String phone}) {
    return profileRemoteDataSource.updateProfile(fullName: fullName, email: email, phone: phone);
  }

}