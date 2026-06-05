import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/data_source/edit_profile_remote_data_source.dart';

import '../model/edit_profile_model.dart';
import 'edit_profile_repositories.dart';

class EditProfileRepositoriesImp  implements EditProfileRepositories {
  final EditProfileRemoteDataSource remoteDataSource;

  EditProfileRepositoriesImp({required this.remoteDataSource});

  @override
  Future<EditProfileModel> editProfile({required String fullName, required String email, required String phoneNumber, required String gender, required int weight, required String bloodType, required String dateOfBirth, required String city, required String governorate, required double lat, required double lng}) {
    return remoteDataSource.editProfile(fullName: fullName, email: email, phoneNumber: phoneNumber, gender: gender, weight: weight, bloodType: bloodType, dateOfBirth: dateOfBirth, city: city, governorate: governorate, lat: lat, lng: lng);
  }



}
