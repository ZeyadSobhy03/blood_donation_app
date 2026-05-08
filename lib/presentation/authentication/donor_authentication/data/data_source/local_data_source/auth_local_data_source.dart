import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart' as login_model;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart' as sign_up_model;

abstract class AuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveUserData({
    required Map<String, dynamic> userData,
  });

  Future<sign_up_model.User?> getUserData();

  Future<void> savSignUpData({
    required sign_up_model.SignUpModel signUpModel,
  });

  Future<sign_up_model.SignUpModel?> getSignUpData();

  Future<void> saveVerificationToken({
    required String verificationToken,
  });

  Future<String?> getVerificationToken();

  Future<void> clearAllData();

  Future<bool> isUserLoggedIn();

  Future<bool> hasTokens();

  Future<void> saveLoginData({
    required login_model.LoginModel loginModel,
  });

  Future<login_model.LoginModel?> getLoginData();
}
