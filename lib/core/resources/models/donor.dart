class DonorModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  final String bloodType;
  final DateTime? lastDonationDate;
  final int totalDonations;
  final int points;

  final bool isEligibleToDonate;
  final bool isActive;
  final bool isVerified;
  final bool isBanned;
  final bool isOnline;

  final String gender;
  final int age;
  final double weight;
  final String healthStatus;

  final String location;
  final double? latitude;
  final double? longitude;
  final double? distanceInKm;

  final String? profileImage;
  final String? deviceToken;

  final DateTime createdAt;
  final DateTime? updatedAt;

  DonorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.bloodType,
    required this.totalDonations,
    required this.points,
    required this.isEligibleToDonate,
    required this.location,
    required this.isActive,
    required this.isVerified,
    required this.gender,
    required this.age,
    required this.weight,
    required this.healthStatus,
    required this.isBanned,
    required this.isOnline,
    required this.createdAt,
    this.lastDonationDate,
    this.latitude,
    this.longitude,
    this.distanceInKm,
    this.profileImage,
    this.deviceToken,
    this.updatedAt,
  });
}