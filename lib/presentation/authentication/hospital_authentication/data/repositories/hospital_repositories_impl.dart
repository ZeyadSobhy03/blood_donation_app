import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/remote_data_source/hospital_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/repositories/hospital_repositories.dart';

class HospitalRepositoriesImp implements HospitalRepositories {
  final HospitalRemoteDataSource hospitalRemoteDataSource;

  HospitalRepositoriesImp({required this.hospitalRemoteDataSource});

  @override
  Future<HospitalLoginModel> login({
    required String hospitalId,
    required String email,
    required String password,
  }) {
    return hospitalRemoteDataSource.login(
      hospitalId: hospitalId,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) {
    return hospitalRemoteDataSource.forgotPassword(email: email);
  }
}