import '../model/edit_profile_model.dart';

abstract class EditProfileRepositories {
  Future<EditProfileModel> editProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String gender,
    required int weight,
    required String bloodType,
    required String dateOfBirth,

    required String city,
    required String governorate,

    required double lat,
    required double lng,
  });

}