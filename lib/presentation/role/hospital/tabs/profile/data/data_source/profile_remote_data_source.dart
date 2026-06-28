import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<HospitalProfileModel> getProfile({required String token});

  Future<void> updateProfile({
    required String token,
    required String hospitalName,
    required String department,
    required String contactNumber,
    required String email,
    required String address,
    double? lat,
    double? lng,
  });

  Future<void> updateWorkingHours({
    required String token,
    required int workingHoursStart,
    required int workingHoursEnd,
    required int slotsPerHour,
  });

  Future<void> updateNotificationPreferences({
    required String token,
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  });

  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
