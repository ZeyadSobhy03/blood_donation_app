import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';

abstract class AdminProfileRemoteDataSource {
  Future<AdminProfileModel> getProfile();
}