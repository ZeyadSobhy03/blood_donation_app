import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/repositories/edit_profile_repositories.dart';

import '../../data/model/edit_profile_model.dart';

class EditProfileUseCase {
  final EditProfileRepositories repository;

  EditProfileUseCase({required this.repository});

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
  }){
    return repository.editProfile(fullName: fullName, email: email, phoneNumber: phoneNumber, gender: gender, weight: weight, bloodType: bloodType, dateOfBirth: dateOfBirth, city: city, governorate: governorate, lat: lat, lng: lng);
  }
}
