class UserModel {
  final String id;
  String name;
  final String email;
  String phone;
  String role;
  final String bloodType;
  final bool isActive;
  final String joinedAt;
  final bool isVerified;
  final int totalDonations;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.bloodType,
    required this.isActive,
    required this.joinedAt, required this.isVerified, required this.totalDonations,
  });
  UserModel copyWith({String? name, String? phone, String? role , }) => UserModel(
    id: id,
    name: name ?? this.name,
    email: email,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    bloodType: bloodType,
    isActive: isActive,
    joinedAt: joinedAt,
    isVerified: isVerified,
    totalDonations: totalDonations
  );
}