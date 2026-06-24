import 'package:blood_donation_app/core/resources/models/create_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/ban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/unban_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';

abstract class UsersRemoteDataSource {
  Future<UsersModel> getUsers({
    required int page,
    required int limit,
    String? role,
    String? search,
  });

  Future<DeleteUserModel> deleteUser({required String userId});

  Future<BanUserModel> banUser({
    required String userId,
    required String reason,
  });

  Future<UnbanUserModel> unbanUser({required String userId});

  Future<HospitalModel> createHospital({
    required CreateHospitalModel createHospitalModel,
  });

  Future<AdminModel> createAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
  });
}
