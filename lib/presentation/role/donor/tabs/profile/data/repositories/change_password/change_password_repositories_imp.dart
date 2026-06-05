import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/change_password/change_password_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/change_password/change_password_repositories.dart';

import '../../data_source/remote/change_password/change_password_remote_data_source.dart';

class ChangePasswordRepositoriesImp  implements ChangePasswordRepositories{
  final ChangePasswordRemoteDataSource remoteDataSource;
  ChangePasswordRepositoriesImp({required this.remoteDataSource});
  @override
  Future<ChangePasswordModel> changePassword({required String currentPassword, required String newPassword, required String confirmNewPassword}) {
    return remoteDataSource.changePassword(currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }

}