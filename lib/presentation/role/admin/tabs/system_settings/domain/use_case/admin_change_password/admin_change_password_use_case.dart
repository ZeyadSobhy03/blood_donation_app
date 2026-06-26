import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/admin_change_password/admin_change_password_repositories.dart';

import '../../../data/model/admin_change_password/admin_change_password_model.dart';

class AdminChangePasswordUseCase {
  final AdminChangePasswordRepositories adminChangePasswordRepositories;
  AdminChangePasswordUseCase({required this.adminChangePasswordRepositories});
  Future<AdminChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return await adminChangePasswordRepositories.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}