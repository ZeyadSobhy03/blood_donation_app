import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/data_source/edit_profile_remote_data_source.dart';

import '../model/edit_profile_model.dart';

class EditProfileRepositoriesImp {
  final EditProfileRemoteDataSource remoteDataSource;

  EditProfileRepositoriesImp({required this.remoteDataSource});

  Future<EditProfileModel> editProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String bloodType,
    required double weight,
    required String age,
    required String gender,
  }) async {
    return await remoteDataSource.editProfile(
      name: name,
      email: email,
      phone: phone,
      location: location,
      bloodType: bloodType,
      weight: weight,
      age: age,
      gender: gender,
    );
  }
}
