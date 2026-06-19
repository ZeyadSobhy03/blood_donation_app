import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
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
}
