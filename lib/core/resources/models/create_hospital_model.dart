
class CreateHospitalModel {
  String name;
  String email;
  String password;
  String hospitalCode;
  String phone;
  double latitude;
  double longitude;
  String address;
  String city;
  String state;
  String zipCode;
  String type;
  String licenseNumber;
  String emergencyContactNumber;
  String adminContactName;
  String adminContactPhone;
  int capacity;
  List<String> bloodBanksAvailable;

  CreateHospitalModel({
    required this.name,
    required this.email,
    required this.password,
    required this.hospitalCode,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.type,
    required this.licenseNumber,
    required this.emergencyContactNumber,
    required this.adminContactName,
    required this.adminContactPhone,
    required this.capacity,
    required this.bloodBanksAvailable,
  });

 factory CreateHospitalModel.fromJson(Map<String, dynamic> json) {
    return CreateHospitalModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      hospitalCode: json['hospitalCode'],
      phone: json['phone'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      type: json['type'],
      licenseNumber: json['licenseNumber'],
      emergencyContactNumber: json['emergencyContactNumber'],
      adminContactName: json['adminContactName'],
      adminContactPhone: json['adminContactPhone'],
      capacity: json['capacity'],
      bloodBanksAvailable: List<String>.from(json['bloodBanksAvailable']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'hospitalCode': hospitalCode,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'type': type,
      'licenseNumber': licenseNumber,
      'emergencyContactNumber': emergencyContactNumber,
      'adminContactName': adminContactName,
      'adminContactPhone': adminContactPhone,
      'capacity': capacity,
      'bloodBanksAvailable': bloodBanksAvailable,
    };
  }
}
