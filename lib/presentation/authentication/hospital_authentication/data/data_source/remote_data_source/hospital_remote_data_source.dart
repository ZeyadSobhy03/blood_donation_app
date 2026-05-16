import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';

abstract class HospitalRemoteDataSource {
  Future<HospitalLoginModel> login({
    required String hospitalId,
    required String email,
    required String password,
  });

  Future<void> forgotPassword({
    required String email,
  });
}