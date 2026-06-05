import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/remote/admin_auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/repositories/admin_auth_repositories.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart';

class AdminAuthRepositoriesImp implements AdminAuthRepositories {
  final AdminAuthRemoteDataSource adminAuthRemoteDataSource;

  AdminAuthRepositoriesImp({required this.adminAuthRemoteDataSource});

  @override
  Future<AdminLoginModel> adminLogin({
    required String accessKey,
    required String email,
    required String password,
  }) {
    return adminAuthRemoteDataSource.adminLogin(
      accessKey: accessKey,
      email: email,
      password: password,
    );
  }

  @override
  Future<MeModel> getMe() {
    return adminAuthRemoteDataSource.getMe();
  }

  @override
  Future<ValidateTokenModel> validateToken() {
    return adminAuthRemoteDataSource.validateToken();
  }

}
