import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/admin_change_password/admin_change_password_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/admin_change_password/admin_change_password_repositories.dart';

import '../../data_source/remote/change_password/admin_change_password_remote_data_source.dart';

class AdminChangePasswordRepositoriesImp implements AdminChangePasswordRepositories {
  final AdminChangePasswordRemoteDataSource remoteDataSource;
  AdminChangePasswordRepositoriesImp({required this.remoteDataSource});

  @override
  Future<AdminChangePasswordModel> changePassword({required String currentPassword, required String newPassword, required String confirmNewPassword}) {
    return remoteDataSource.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }

}