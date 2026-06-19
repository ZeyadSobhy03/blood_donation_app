import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/repositories/users_repositories.dart';

import '../../data/model/delete_user_model.dart';
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

}