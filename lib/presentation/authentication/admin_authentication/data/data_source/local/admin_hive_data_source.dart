import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_auth_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart' as admin_login_model;
import 'package:hive_ce/hive.dart';

class AdminHiveDataSource implements AdminAuthLocalDataSource {
  static const String _adminAuthBoxName = 'admin_auth_box';
  static const String _accessTokenKey = 'admin_access_token';
  static const String _refreshTokenKey = 'admin_refresh_token';
  static const String _adminDataKey = 'admin_data';
  static const String _loginDataKey = 'admin_login_data';

  late Box _adminAuthBox;

  Future<void> init() async {
    _adminAuthBox = await Hive.openBox(_adminAuthBoxName);
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _adminAuthBox.put(_accessTokenKey, accessToken);
      await _adminAuthBox.put(_refreshTokenKey, refreshToken);
    } catch (e) {
      throw Exception('Failed to save tokens: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return _adminAuthBox.get(_accessTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get access token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _adminAuthBox.get(_refreshTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get refresh token: $e');
    }
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    try {
      await _adminAuthBox.put(_accessTokenKey, accessToken);
    } catch (e) {
      throw Exception('Failed to save access token: $e');
    }
  }

  @override
  Future<void> saveAdminData({
    required Map<String, dynamic> adminData,
  }) async {
    try {
      await _adminAuthBox.put(_adminDataKey, adminData);
    } catch (e) {
      throw Exception('Failed to save admin data: $e');
    }
  }

  @override
  Future<admin_login_model.User?> getAdminData() async {
    try {
      final adminData = _adminAuthBox.get(_adminDataKey);
      if (adminData == null) return null;
      return admin_login_model.User.fromJson(adminData as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get admin data: $e');
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await _adminAuthBox.clear();
    } catch (e) {
      throw Exception('Failed to clear admin authentication data: $e');
    }
  }

  @override
  Future<bool> isAdminLoggedIn() async {
    try {
      // Guard: ensure box is open
      if (!_adminAuthBox.isOpen) {
        await init();
      }

      final accessToken = _adminAuthBox.get(_accessTokenKey) as String?;
      final refreshToken = _adminAuthBox.get(_refreshTokenKey) as String?;

      return accessToken != null &&
          accessToken.isNotEmpty &&
          refreshToken != null &&
          refreshToken.isNotEmpty;
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
    required admin_login_model.AdminLoginModel loginModel,
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
        await saveAdminData(adminData: user.toJson());
      }

      await _adminAuthBox.put(_loginDataKey, loginModel.toJson());
    } catch (e) {
      throw Exception('Failed to save login data: $e');
    }
  }

  @override
  Future<admin_login_model.AdminLoginModel?> getLoginData() async {
    try {
      final data = _adminAuthBox.get(_loginDataKey);
      if (data == null) return null;
      return admin_login_model.AdminLoginModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get login data: $e');
    }
  }
}

