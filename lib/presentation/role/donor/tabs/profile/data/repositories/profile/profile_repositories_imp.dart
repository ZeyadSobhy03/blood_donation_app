import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/profile/profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/profile/profile_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/profile/profile_repositories.dart';

class ProfileRepositoriesImp implements ProfileRepositories {
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoriesImp({required this.profileRemoteDataSource});
  @override
  Future<ProfileModel> getProfile() {
    return profileRemoteDataSource.getProfile();
  }
}