import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/repositories/hospital_repositories.dart';

class HospitalUseCase {
  final HospitalRepositories hospitalRepositories;

  HospitalUseCase({required this.hospitalRepositories});

  Future<HospitalLoginModel> login({
    required String hospitalId,
    required String email,
    required String password,
  }) {
    return hospitalRepositories.login(
      hospitalId: hospitalId,
      email: email,
      password: password,
    );
  }

  Future<void> forgotPassword({required String email}) {
    return hospitalRepositories.forgotPassword(email: email);
  }

  Future<void> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    return hospitalRepositories.logOut(
      refreshToken: refreshToken,
      fcmToken: fcmToken,
    );
  }
}