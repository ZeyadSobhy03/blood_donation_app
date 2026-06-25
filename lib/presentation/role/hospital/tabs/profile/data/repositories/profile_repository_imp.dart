import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/data_source/profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/repositories/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImp({required this.profileRemoteDataSource});

  @override
  Future<HospitalProfileModel> getProfile({required String token}) {
    return profileRemoteDataSource.getProfile(token: token);
  }

  @override
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
    return profileRemoteDataSource.updateProfile(
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

  @override
  Future<void> updateWorkingHours({
    required String token,
    required int workingHoursStart,
    required int workingHoursEnd,
    required int slotsPerHour,
  }) {
    return profileRemoteDataSource.updateWorkingHours(
      token: token,
      workingHoursStart: workingHoursStart,
      workingHoursEnd: workingHoursEnd,
      slotsPerHour: slotsPerHour,
    );
  }

  @override
  Future<void> updateNotificationPreferences({
    required String token,
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  }) {
    return profileRemoteDataSource.updateNotificationPreferences(
      token: token,
      pushNotifications: pushNotifications,
      emergencyAlerts: emergencyAlerts,
      emailNotifications: emailNotifications,
      smsAlerts: smsAlerts,
    );
  }

  @override
  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return profileRemoteDataSource.changePassword(
      token: token,
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
