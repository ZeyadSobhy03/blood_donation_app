import '../../../../../../../core/resources/models/create_hospital_model.dart';
import '../model/admin_model.dart';
import '../model/admin_update_admin_model.dart';
import '../model/admin_update_donor_model.dart';
import '../model/admin_update_hospital_model.dart';
import '../model/ban_user_model.dart';
import '../model/delete_user_model.dart';
import '../model/hospital_model.dart';
import '../model/unban_user_model.dart';
import '../model/users_model.dart';

abstract class UsersRepositories {
  Future<UsersModel> getUsers({
    required int page,
    required int limit,
     String? role,
     String? search,
  });
  Future<DeleteUserModel> deleteUser({required String userId});
  Future<BanUserModel> banUser({required String userId, required String reason});
  Future<UnbanUserModel> unbanUser({required String userId});
  Future<HospitalModel> createHospital({
    required CreateHospitalModel createHospitalModel,
  });
  Future<AdminModel> createAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role
  });
  Future<AdminUpdateDonorModel> updateDonor({
    required String fullName,
    required String phoneNumber,
    required String bloodType,
    required String userId,
  });

  Future<AdminUpdateHospitalModel> updateHospital({
    required String fullName,
    required String hospitalName,
    required String phone,
    required List<String> bloodBanksAvailable,
    required int capacity,
    required String userId,
  });

  Future<AdminUpdateAdminModel> updateAdmin({
    required String fullName,
    required bool isSuspended,
    required String userId,
  });
}
