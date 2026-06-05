import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/change_password/change_password_model.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
}