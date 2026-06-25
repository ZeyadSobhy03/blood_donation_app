import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/repositories/profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<HospitalProfileModel> getProfile({required String token}) {
    return profileRepository.getProfile(token: token);
  }

  Future<void> updateProfile({
    required String token,
    required String hospitalName,
    required String department,
    required String contactNumber,
    required String email,
    required String address,
    double? lat,
    double? lng,
  }) {
    return profileRepository.updateProfile(
      token: token,
      hospitalName: hospitalName,
      department: department,
      contactNumber: contactNumber,
      email: email,
      address: address,
      lat: lat,
      lng: lng,
    );
  }

  Future<void> updateWorkingHours({
    required String token,
    required int workingHoursStart,
    required int workingHoursEnd,
    required int slotsPerHour,
  }) {
    return profileRepository.updateWorkingHours(
      token: token,
      workingHoursStart: workingHoursStart,
      workingHoursEnd: workingHoursEnd,
      slotsPerHour: slotsPerHour,
    );
  }

  Future<void> updateNotificationPreferences({
    required String token,
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  }) {
    return profileRepository.updateNotificationPreferences(
      token: token,
      pushNotifications: pushNotifications,
      emergencyAlerts: emergencyAlerts,
      emailNotifications: emailNotifications,
      smsAlerts: smsAlerts,
    );
  }

  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return profileRepository.changePassword(
      token: token,
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
