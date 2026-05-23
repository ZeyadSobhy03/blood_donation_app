import '../model/edit_profile_model.dart';

abstract class EditProfileRepositories {
  Future<EditProfileModel> editProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String bloodType,
    required double weight,
    required String age,
    required String gender,
  });

}