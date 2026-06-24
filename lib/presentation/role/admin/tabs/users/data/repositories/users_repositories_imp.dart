import 'package:blood_donation_app/core/resources/models/create_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_update_admin_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_update_donor_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_update_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/ban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/unban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/repositories/users_repositories.dart';

class UsersRepositoriesImp implements UsersRepositories {
  final UsersRemoteDataSource usersRemoteDataSource;

  UsersRepositoriesImp({required this.usersRemoteDataSource});

  @override
  Future<UsersModel> getUsers({required int page, required int limit, String? role, String? search}) {
    return usersRemoteDataSource.getUsers(page: page, limit: limit, role: role, search: search);
  }

  @override
  Future<DeleteUserModel> deleteUser({required String userId}) {
    return usersRemoteDataSource.deleteUser(userId: userId);
  }

  @override
  Future<BanUserModel> banUser({required String userId, required String reason}) {
    return usersRemoteDataSource.banUser(userId: userId, reason: reason);
  }

  @override
  Future<UnbanUserModel> unbanUser({required String userId}) {
    return usersRemoteDataSource.unbanUser(userId: userId);
  }

  @override
  Future<HospitalModel> createHospital({required CreateHospitalModel createHospitalModel}) {
    return usersRemoteDataSource.createHospital(createHospitalModel: createHospitalModel);
  }

  @override
  Future<AdminModel> createAdmin({required String fullName, required String email, required String password, required String phone,required String role}) {
    return usersRemoteDataSource.createAdmin(fullName: fullName, email: email, password: password, phone: phone, role: role);
  }

  @override
  Future<AdminUpdateAdminModel> updateAdmin({required String fullName, required bool isSuspended, required String userId}) {
    return usersRemoteDataSource.updateAdmin(fullName: fullName, isSuspended: isSuspended, userId: userId);
  }

  @override
  Future<AdminUpdateDonorModel> updateDonor({required String fullName, required String phoneNumber, required String bloodType, required String userId}) {
    return usersRemoteDataSource.updateDonor(fullName: fullName, phoneNumber: phoneNumber, bloodType: bloodType, userId: userId);
  }

  @override
  Future<AdminUpdateHospitalModel> updateHospital({required String fullName, required String hospitalName, required String phone, required List<String> bloodBanksAvailable, required int capacity, required String userId}) {
    return usersRemoteDataSource.updateHospital(fullName: fullName, hospitalName: hospitalName, phone: phone, bloodBanksAvailable: bloodBanksAvailable, capacity: capacity, userId: userId);
  }
}
