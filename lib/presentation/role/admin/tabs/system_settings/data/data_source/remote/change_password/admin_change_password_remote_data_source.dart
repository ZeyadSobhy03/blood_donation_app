
import '../../../model/admin_change_password/admin_change_password_model.dart';

abstract class AdminChangePasswordRemoteDataSource {
  Future<AdminChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,

  });
}
