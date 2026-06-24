import 'package:blood_donation_app/core/resources/models/create_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/admin_model.dart';
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
}
