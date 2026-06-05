import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_otp_model.dart';

import '../model/forget_password_model.dart';
import '../model/log_out_model.dart';
import '../model/me_model.dart';
import '../model/reset_password_model.dart';
import '../model/sign_up_model.dart';
import '../model/validate_token_model.dart';
import '../model/verify_email_model.dart';

abstract class AuthRepositories {
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
  });
  Future<VerifyEmailModel> verifyEmail({required String email});

  Future<VerifyEmailModel> verifyEmailOtp({
    required String email,
    required String otp,
  });
  Future<LoginModel>login({
    required String email,
    required String password,
    required String role,
  });
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  });
  Future<ForgetPasswordModel>forgetPassword({
    required String email,
  });
  Future<VerifyOtpModel> verifyForgetPasswordOtp({
    required String email,
    required String otp,
  });
  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String otp,
    required String password,
  });
  Future<MeModel> getMe();
  Future<ValidateTokenModel>validateToken();



}