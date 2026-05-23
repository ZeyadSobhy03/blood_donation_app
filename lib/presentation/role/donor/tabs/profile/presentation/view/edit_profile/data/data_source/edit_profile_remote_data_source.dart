import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/model/edit_profile_model.dart';

abstract class EditProfileRemoteDataSource {
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
