import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/profile_repositories.dart';

import '../../data/model/profile_model.dart';

class ProfileUseCase {
  ProfileRepositories profileRepositories;
  ProfileUseCase({required this.profileRepositories});
  Future<ProfileModel>getProfile(){
    return profileRepositories.getProfile();
  }
}