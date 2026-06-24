class DonationSchedule {
  // Step 1 - Location
  String? location;
  String? hospitalId;

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
    this.bloodType,
    this.hospitalId
  });

  static const _undefined = Object();

  DonationSchedule copyWith({
    Object? location = _undefined,
    Object? date = _undefined,
    Object? timeSlot = _undefined,
    Object? donationType = _undefined,
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? phone = _undefined,
    Object? email = _undefined,
    Object? bloodType = _undefined,
    Object? hospitalId = _undefined,
  }) {
    return DonationSchedule(
        hospitalId:   hospitalId   == _undefined ? this.hospitalId   : hospitalId   as String?,
      location:     location     == _undefined ? this.location     : location     as String?,
      date:         date         == _undefined ? this.date         : date         as DateTime?,
      timeSlot:     timeSlot     == _undefined ? this.timeSlot     : timeSlot     as String?,
      donationType: donationType == _undefined ? this.donationType : donationType as String?,
      firstName:    firstName    == _undefined ? this.firstName    : firstName    as String?,
      lastName:     lastName     == _undefined ? this.lastName     : lastName     as String?,
      phone:        phone        == _undefined ? this.phone        : phone        as String?,
      email:        email        == _undefined ? this.email        : email        as String?,
      bloodType:    bloodType    == _undefined ? this.bloodType    : bloodType    as String?,
    );
  }
}