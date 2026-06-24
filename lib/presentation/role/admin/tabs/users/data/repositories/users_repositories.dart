import '../../../../../../../core/resources/models/create_hospital_model.dart';
import '../model/admin_model.dart';
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
}
