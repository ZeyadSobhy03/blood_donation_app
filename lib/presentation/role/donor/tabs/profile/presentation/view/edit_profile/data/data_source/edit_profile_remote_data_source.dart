import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/model/edit_profile_model.dart';

abstract class EditProfileRemoteDataSource {
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