import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/repositories/users_repositories.dart';

import '../../../../../../../core/resources/models/create_hospital_model.dart';
import '../../data/model/admin_model.dart';
import '../../data/model/admin_update_admin_model.dart';
import '../../data/model/admin_update_donor_model.dart';
import '../../data/model/admin_update_hospital_model.dart';
import '../../data/model/ban_user_model.dart';
import '../../data/model/delete_user_model.dart';
import '../../data/model/hospital_model.dart';
import '../../data/model/unban_user_model.dart';
import '../../data/model/users_model.dart';

class UsersUseCase {
  final UsersRepositories usersRepositories;
  UsersUseCase({required this.usersRepositories});
  Future<UsersModel> getUsers({required int page, required int limit,  String? role,  String? search}) {
    return usersRepositories.getUsers(page: page, limit: limit, role: role, search: search);
  }
  Future<DeleteUserModel> deleteUser({required String userId}){
    return usersRepositories.deleteUser(userId: userId);
  }
  Future<BanUserModel> banUser({required String userId, required String reason}){
    return usersRepositories.banUser(userId: userId, reason: reason);
  }
  Future<UnbanUserModel> unbanUser({required String userId}){
    return usersRepositories.unbanUser(userId: userId);
  }
  Future<HospitalModel> createHospital({
    required CreateHospitalModel createHospitalModel,
  }){
    return usersRepositories.createHospital(createHospitalModel: createHospitalModel);
  }
  Future<AdminModel> createAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
  }){
    return usersRepositories.createAdmin(fullName: fullName, email: email, password: password, phone: phone, role: role);
  }
  Future<AdminUpdateDonorModel> updateDonor({
    required String fullName,
    required String phoneNumber,
    required String bloodType,
    required String userId,
  }){
    return usersRepositories.updateDonor(fullName: fullName, phoneNumber: phoneNumber, bloodType: bloodType, userId: userId);
  }

  Future<AdminUpdateHospitalModel> updateHospital({
    required String fullName,
    required String hospitalName,
    required String phone,
    required List<String> bloodBanksAvailable,
    required int capacity,
    required String userId,
  }){
    return usersRepositories.updateHospital(
      fullName: fullName,
      hospitalName: hospitalName,
      phone: phone,
      bloodBanksAvailable: bloodBanksAvailable,
      capacity: capacity,
      userId: userId,
    );
  }

  Future<AdminUpdateAdminModel> updateAdmin({
    required String fullName,
    required bool isSuspended,
    required String userId,
  }){
    return usersRepositories.updateAdmin(
      fullName: fullName,
      isSuspended: isSuspended,
      userId: userId,
    );
  }

}