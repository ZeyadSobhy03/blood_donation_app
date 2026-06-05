import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories.dart';

import '../../data/model/forget_password_model.dart';
import '../../data/model/log_out_model.dart';
import '../../data/model/me_model.dart';
import '../../data/model/reset_password_model.dart';
import '../../data/model/sign_up_model.dart';
import '../../data/model/validate_token_model.dart';
import '../../data/model/verify_email_model.dart';
import '../../data/model/verify_otp_model.dart';

class AuthUseCase {
  AuthRepositories authRepositories;

  AuthUseCase({required this.authRepositories});

  Future<SignUpModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String gender,
    required String city,
    required String governorate,
    required double lat,
    required double lng,
  }) {
    return authRepositories.signUp(
      fullName: fullName,
      email: email,
      password: password,
      role: role,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      bloodType: bloodType,
      confirmPassword: confirmPassword,
      lng: lng,
      gender: gender,
      lat: lat,
      city: city,
      governorate: governorate,
    );
  }
  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) {
    return authRepositories.resetPassword(email: email, otp: otp, password: password);
  }
  Future<VerifyOtpModel> verifyForgetPasswordOtp({
    required String email,
    required String otp,
  }) {
    return authRepositories.verifyForgetPasswordOtp(email: email, otp: otp);
  }
  Future<ForgetPasswordModel>forgetPassword({
    required String email,
  }) {
    return authRepositories.forgetPassword(email: email);
  }

  Future<VerifyEmailModel> verifyEmail({required String email}) {
    return authRepositories.verifyEmail(email: email);
  }

  Future<VerifyEmailModel> verifyEmailOtp({
    required String email,
    required String otp,
  }) {
    return authRepositories.verifyEmailOtp(email: email, otp: otp);
  }

  Future<LoginModel> login({
    required String email,
    required String password,
    required String role,
  }) {
    return authRepositories.login(email: email, password: password, role: role);
  }

  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    return authRepositories.logOut(
      refreshToken: refreshToken,
      fcmToken: fcmToken,
    );
  }
  Future<MeModel> getMe(){
    return authRepositories.getMe();

  }
  Future<ValidateTokenModel>validateToken(){
    return authRepositories.validateToken();
  }
}
