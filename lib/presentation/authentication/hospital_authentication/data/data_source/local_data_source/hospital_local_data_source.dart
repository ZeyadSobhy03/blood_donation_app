import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';

abstract class HospitalLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> saveLoginData({
    required HospitalLoginModel loginModel,
  });

  Future<HospitalLoginModel?> getLoginData();

  Future<void> saveUserData({required Map<String, dynamic> userData});

  Future<HospitalUser?> getUserData();

  Future<bool> isUserLoggedIn();

  Future<bool> hasTokens();

  Future<void> clearAllData();
}