class DonationBookingCardModel {
  // Step 1 - Location
  String? location;
  String? hospitalName;

  // Step 2 - Date & Time
  DateTime? date;
  String? timeSlot;
  String? donationType;
  String? hospitalDistance;
  bool? isConfirmed;
  String? appointmentId;
  DateTime? createdAt;
  DateTime? updatedAt;


  // Step 3 - User Details
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? bloodType;





  DonationBookingCardModel({
    required this.donationType,
    required this.hospitalName,
    required this.hospitalDistance,
    required this.isConfirmed,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.bloodType,
    required this.appointmentId,
    required this.date,
    required this.timeSlot,
    required this.createdAt,
    required this.updatedAt,
  });

  DonationBookingCardModel copyWith({
    String? donationType,
    String? hospitalName,
    String? hospitalDistance,
    bool? isConfirmed,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? bloodType,
    String? appointmentId,
    DateTime? date,
    String? timeSlot,
    DateTime? createdAt,
    DateTime? updatedAt,

  }) {
    return DonationBookingCardModel(
      donationType: donationType ?? this.donationType,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalDistance: hospitalDistance ?? this.hospitalDistance,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bloodType: bloodType ?? this.bloodType,
      appointmentId: appointmentId ?? this.appointmentId,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
