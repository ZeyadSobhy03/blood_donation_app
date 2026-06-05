import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/forget_password_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/log_out_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/reset_password_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_otp_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoriesImp({required this.authRemoteDataSource});

  @override
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
    return authRemoteDataSource.signUp(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      role: role,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      bloodType: bloodType,
      gender: gender,
      lng: lng,
      lat: lat,
      city: city,
      governorate: governorate,
    );
  }

  @override
  Future<VerifyEmailModel> verifyEmail({required String email}) async {
    return await authRemoteDataSource.verifyEmail(email: email);
  }

  @override
  Future<VerifyEmailModel> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    return await authRemoteDataSource.verifyEmailOtp(email: email, otp: otp);
  }

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
    required String role,
  }) {
    return authRemoteDataSource.login(
      email: email,
      password: password,
      role: role,
    );
  }

  @override
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    return authRemoteDataSource.logOut(
      refreshToken: refreshToken,
      fcmToken: fcmToken,
    );
  }

  @override
  Future<ForgetPasswordModel> forgetPassword({required String email}) {
    return authRemoteDataSource.forgetPassword(email: email);
  }

  @override
  Future<VerifyOtpModel> verifyForgetPasswordOtp({required String email, required String otp}) {
    return authRemoteDataSource.verifyForgetPasswordOtp(email: email, otp: otp);
  }

  @override
  Future<ResetPasswordModel> resetPassword({required String email, required String otp, required String password}) {
    return authRemoteDataSource.resetPassword(email: email, otp: otp, password: password);
  }

  @override
  Future<MeModel> getMe() {
    return authRemoteDataSource.getMe();
  }

  @override
  Future<ValidateTokenModel> validateToken() {
    return authRemoteDataSource.validateToken();
  }

}
