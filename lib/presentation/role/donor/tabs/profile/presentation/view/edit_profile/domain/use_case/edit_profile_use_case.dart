import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/repositories/edit_profile_repositories.dart';

import '../../data/model/edit_profile_model.dart';

class EditProfileUseCase {
  final EditProfileRepositories repository;

  EditProfileUseCase({required this.repository});

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
    return await repository.editProfile(
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
