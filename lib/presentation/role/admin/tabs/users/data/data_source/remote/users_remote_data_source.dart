import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/delete_user_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';

abstract class UsersRemoteDataSource {
  Future<UsersModel> getUsers({
   required int page ,
    required  int limit ,
     String? role,
     String? search,
});
  Future<DeleteUserModel> deleteUser({required String userId});
}