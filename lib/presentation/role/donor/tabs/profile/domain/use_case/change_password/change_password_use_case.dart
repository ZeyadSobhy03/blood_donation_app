import '../../../data/model/change_password/change_password_model.dart';
import '../../../data/repositories/change_password/change_password_repositories.dart';

class ChangePasswordUseCase {

  final ChangePasswordRepositories repository;
  ChangePasswordUseCase({required this.repository});
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return repository.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }
}