import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart' as admin_login_model;

abstract class AdminAuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveAccessToken(String accessToken);

  Future<void> saveAdminData({
    required Map<String, dynamic> adminData,
  });

  Future<admin_login_model.User?> getAdminData();

  Future<void> clearAllData();

  Future<bool> isAdminLoggedIn();

  Future<bool> hasTokens();

  Future<void> saveLoginData({
    required admin_login_model.AdminLoginModel loginModel,
  });

  Future<admin_login_model.AdminLoginModel?> getLoginData();
}
