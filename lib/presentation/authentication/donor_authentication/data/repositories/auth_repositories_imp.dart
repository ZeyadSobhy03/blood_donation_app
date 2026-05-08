import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoriesImp({required this.authRemoteDataSource});

  @override
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
    return authRemoteDataSource.signUp(
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

  @override
  Future<VerifyEmailModel> verifyEmail({required String email})async {
    return await authRemoteDataSource.verifyEmail(email: email);
  }

  @override
  Future<VerifyEmailModel> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    return await authRemoteDataSource.verifyEmailOtp(
      email: email,
      otp: otp,
    );
  }

  @override
  Future<LoginModel> login({required String email, required String password, required String role}) {
    return authRemoteDataSource.login(
      email: email,
      password: password,
      role: role,
    );
  }
}
