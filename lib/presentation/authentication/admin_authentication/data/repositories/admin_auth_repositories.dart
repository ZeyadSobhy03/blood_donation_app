import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart';

import '../../../donor_authentication/data/model/me_model.dart';

abstract class AdminAuthRepositories {
  Future<AdminLoginModel> adminLogin({
    required String accessKey,
    required String email,
    required String password,
  });

  Future<MeModel> getMe();
  Future<ValidateTokenModel>validateToken();}
