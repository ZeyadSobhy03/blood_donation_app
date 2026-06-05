import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/repositories/admin_auth_repositories.dart';

import '../../../donor_authentication/data/model/me_model.dart';
import '../../../donor_authentication/data/model/validate_token_model.dart';

class AdminAuthUseCase {
  AdminAuthRepositories adminAuthRepositories;

  AdminAuthUseCase({required this.adminAuthRepositories});

  Future<AdminLoginModel> adminLogin({
    required String accessKey,
    required String email,
    required String password,
  }) {
    return adminAuthRepositories.adminLogin(
      accessKey: accessKey,
      email: email,
      password: password,
    );
  }
  Future<MeModel> getMe() {
    return adminAuthRepositories.getMe();
  }
  Future<ValidateTokenModel>validateToken()
{
    return adminAuthRepositories.validateToken();
  }
}
