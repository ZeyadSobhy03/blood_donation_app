class DonationSchedule {
  // Step 1 - Location
  String? location;

  // Step 2 - Date & Time
  DateTime? date;
  String? timeSlot;
  String? donationType;

  // Step 3 - User Details
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? bloodType;

  DonationSchedule({
    this.location,
    this.date,
    this.timeSlot,
    this.donationType,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.bloodType
  });
  DonationSchedule copyWith({
    String? location,
    DateTime? date,
    String? timeSlot,
    String? donationType,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? bloodType
  }) {
    return DonationSchedule(
      location: location ?? this.location,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      donationType: donationType ?? this.donationType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bloodType: bloodType ?? this.bloodType
    );
  }



}
