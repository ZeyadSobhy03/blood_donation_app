import '../model/delete_user_model.dart';
import '../model/users_model.dart';

abstract class UsersRepositories {
  Future<UsersModel> getUsers({
    required int page,
    required int limit,
     String? role,
     String? search,
  });
  Future<DeleteUserModel> deleteUser({required String userId});
}
