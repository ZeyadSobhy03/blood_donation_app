import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:hive_ce/hive.dart';

class HospitalHiveDataSource implements HospitalLocalDataSource {
  static const String _authBoxName = 'hospital_auth_box';
  static const String _accessTokenKey = 'hospital_access_token';
  static const String _refreshTokenKey = 'hospital_refresh_token';
  static const String _userDataKey = 'hospital_user_data';
  static const String _loginDataKey = 'hospital_login_data';

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
      throw Exception('Failed to save hospital tokens: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return _authBox.get(_accessTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get hospital access token: $e');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _authBox.get(_refreshTokenKey) as String?;
    } catch (e) {
      throw Exception('Failed to get hospital refresh token: $e');
    }
  }


  @override
  Future<void> saveUserData({required Map<String, dynamic> userData}) async {
    try {
      await _authBox.put(_userDataKey, userData);
    } catch (e) {
      throw Exception('Failed to save hospital user data: $e');
    }
  }

  @override
  Future<HospitalUser?> getUserData() async {
    try {
      final userData = _authBox.get(_userDataKey);
      if (userData == null) return null;
      return HospitalUser.fromJson(userData as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get hospital user data: $e');
    }
  }


  @override
  Future<void> saveLoginData({required HospitalLoginModel loginModel}) async {
    try {
      final data = loginModel.data;

      final accessToken = data?.accessToken;
      final refreshToken = data?.refreshToken;
      if (accessToken != null && refreshToken != null) {
        await saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }

      final user = data?.user;
      if (user != null) {
        await saveUserData(userData: user.toJson());
      }

      await _authBox.put(_loginDataKey, loginModel.toJson());
    } catch (e) {
      throw Exception('Failed to save hospital login data: $e');
    }
  }

  @override
  Future<HospitalLoginModel?> getLoginData() async {
    try {
      final data = _authBox.get(_loginDataKey);
      if (data == null) return null;
      return HospitalLoginModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get hospital login data: $e');
    }
  }


  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final accessToken = await getAccessToken();
      final user = await getUserData();
      return accessToken != null && accessToken.isNotEmpty && user != null;
    } catch (_) {
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
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await _authBox.clear();
    } catch (e) {
      throw Exception('Failed to clear hospital authentication data: $e');
    }
  }
}