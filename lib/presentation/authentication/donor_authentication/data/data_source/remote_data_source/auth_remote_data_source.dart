import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String confirmPassword,
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
}
