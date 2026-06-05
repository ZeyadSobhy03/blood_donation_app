import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart' as login_model;
import 'package:hive_ce/hive.dart';

import '../../model/sign_up_model.dart' as sign_up_model;


class AuthHiveDataSource implements AuthLocalDataSource {
  static const String _authBoxName = 'auth_box';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _signUpDataKey = 'sign_up_data';
  static const String _verificationTokenKey = 'verification_token';
  static const String _loginDataKey = 'login_data';

  late Box _authBox;

  Future<void> init() async {
    _authBox = await Hive.openBox(_authBoxName);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _authBox.put(_accessTokenKey, accessToken);
      await _authBox.put(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw Exception('Failed to save tokens: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return _authBox.get(_accessTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get access token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _authBox.get(_refreshTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get refresh token: $e');
    }
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    try {
      await _authBox.put(_accessTokenKey, accessToken);
    } catch (e) {
      throw Exception('Failed to save access token: $e');
    }
  }

  @override
  Future<void> saveUserData({
    required Map<String, dynamic> userData,
  }) async {
    try {
      await _authBox.put(_userDataKey, userData);
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  @override
  Future<sign_up_model.User?> getUserData() async {
    try {
      final userData = _authBox.get(_userDataKey);
      if (userData == null) return null;
      return sign_up_model.User.fromJson(userData as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  @override
  Future<void> savSignUpData({
    required sign_up_model.SignUpModel signUpModel,
  }) async {
    try {
      await _authBox.put(_signUpDataKey, signUpModel.toJson());
    } catch (e) {
      throw Exception('Failed to save sign-up data: $e');
    }
  }

  @override
  Future<sign_up_model.SignUpModel?> getSignUpData() async {
    try {
      final data = _authBox.get(_signUpDataKey);
      if (data == null) return null;
      return sign_up_model.SignUpModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get sign-up data: $e');
    }
  }

  @override
  Future<void> saveVerificationToken({
    required String verificationToken,
  }) async {
    try {
      await _authBox.put(_verificationTokenKey, verificationToken);
    } catch (e) {
      throw Exception('Failed to save verification token: $e');
    }
  }

  @override
  Future<String?> getVerificationToken() async {
    try {
      return _authBox.get(_verificationTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get verification token: $e');
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await _authBox.clear();
    } catch (e) {
      throw Exception('Failed to clear authentication data: $e');
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final accessToken = _authBox.get(_accessTokenKey) as String?;
      final refreshToken = _authBox.get(_refreshTokenKey) as String?;
      final userData = _authBox.get(_userDataKey);

      return accessToken != null &&
          accessToken.isNotEmpty &&
          refreshToken != null &&
          refreshToken.isNotEmpty &&
          userData != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> hasTokens() async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      return (accessToken != null && accessToken.isNotEmpty) &&
          (refreshToken != null && refreshToken.isNotEmpty);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveLoginData({
    required login_model.LoginModel loginModel,
  }) async {
    try {
      final data = loginModel.data;
      final accessToken = data?.accessToken;
      final refreshToken = data?.refreshToken;

      if (accessToken != null && refreshToken != null) {
        await saveTokens(accessToken: accessToken, refreshToken: refreshToken);
      }

      final user = data?.user;
      if (user != null) {
        await saveUserData(userData: user.toJson());
      }

      await _authBox.put(_loginDataKey, loginModel.toJson());
    } catch (e) {
      throw Exception('Failed to save login data: $e');
    }
  }

  @override
  Future<login_model.LoginModel?> getLoginData() async {
    try {
      final data = _authBox.get(_loginDataKey);
      if (data == null) return null;
      return login_model.LoginModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get login data: $e');
    }
  }
}
