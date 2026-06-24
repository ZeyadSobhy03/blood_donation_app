/// success : true
/// message : "Hospital created successfully"
/// data : {"hospital":{"_id":"69f3df925f42685cbbbcbb1d","fullName":"Alexandria Demo Hospital","hospitalName":"Alexandria Demo Hospital","email":"alex.demo@lifelink.demo","role":"hospital","hospitalId":"HOSP-ALEX-001","contactNumber":"1066666666","isEmailVerified":true}}

class HospitalModel {
  HospitalModel({
      this.success, 
      this.message, 
      this.data,});

  HospitalModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// hospital : {"_id":"69f3df925f42685cbbbcbb1d","fullName":"Alexandria Demo Hospital","hospitalName":"Alexandria Demo Hospital","email":"alex.demo@lifelink.demo","role":"hospital","hospitalId":"HOSP-ALEX-001","contactNumber":"1066666666","isEmailVerified":true}

class Data {
  Data({
      this.hospital,});

  Data.fromJson(dynamic json) {
    hospital = json['hospital'] != null ? Hospital.fromJson(json['hospital']) : null;
  }
  Hospital? hospital;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hospital != null) {
      map['hospital'] = hospital?.toJson();
    }
    return map;
  }

}

/// _id : "69f3df925f42685cbbbcbb1d"
/// fullName : "Alexandria Demo Hospital"
/// hospitalName : "Alexandria Demo Hospital"
/// email : "alex.demo@lifelink.demo"
/// role : "hospital"
/// hospitalId : "HOSP-ALEX-001"
/// contactNumber : "1066666666"
/// isEmailVerified : true

class Hospital {
  Hospital({
      this.id, 
      this.fullName, 
      this.hospitalName, 
      this.email, 
      this.role, 
      this.hospitalId, 
      this.contactNumber, 
      this.isEmailVerified,});

  Hospital.fromJson(dynamic json) {
    id = json['_id'];
    fullName = json['fullName'];
    hospitalName = json['hospitalName'];
    email = json['email'];
    role = json['role'];
    hospitalId = json['hospitalId'];
    contactNumber = json['contactNumber'];
    isEmailVerified = json['isEmailVerified'];
  }
  String? id;
  String? fullName;
  String? hospitalName;
  String? email;
  String? role;
  String? hospitalId;
  String? contactNumber;
  bool? isEmailVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['fullName'] = fullName;
    map['hospitalName'] = hospitalName;
    map['email'] = email;
    map['role'] = role;
    map['hospitalId'] = hospitalId;
    map['contactNumber'] = contactNumber;
    map['isEmailVerified'] = isEmailVerified;
    return map;
  }

}