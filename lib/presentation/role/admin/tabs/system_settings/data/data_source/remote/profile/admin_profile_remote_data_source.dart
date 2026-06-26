import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_update_model.dart';

abstract class AdminProfileRemoteDataSource {
  Future<AdminProfileModel> getProfile();
  Future<AdminProfileUpdateModel> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  });
}
