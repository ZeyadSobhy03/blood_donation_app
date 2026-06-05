import '../../model/change_password/change_password_model.dart';

abstract class ChangePasswordRepositories {
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
}