import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories.dart';

import '../../data/model/sign_up_model.dart';
import '../../data/model/verify_email_model.dart';

class AuthUseCase {
  AuthRepositories authRepositories;

  AuthUseCase({required this.authRepositories});

  Future<SignUpModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String confirmPassword,
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
    );
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
}
