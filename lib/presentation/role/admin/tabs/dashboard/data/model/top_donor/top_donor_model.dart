/// success : true
/// message : "Top donors"
/// data : {"topDonors":[{"_id":"6a130e810b339a45a51addaf","completedDonations":3,"totalUnits":3,"lastDonation":"2026-06-04T07:00:00.000Z","donor":{"fullName":"Mariam Adel","email":"mariam.adel@lifelink.demo","location":{"city":"Nasr City","governorate":"Cairo","coordinates":{"lat":30.0637,"lng":31.3303},"lastUpdated":"2026-06-07T03:40:10.221Z"},"bloodType":"B+"}},{"_id":"6a1c6445a3e567d226796e4e","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:39:39.802Z","donor":{"fullName":"Test Donor 85727","email":"donor85727_1780245573800@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:39:33.800Z"},"bloodType":"O+"}},{"_id":"6a1a03f485d2cd97a5b5c070","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-19T21:24:05.023Z","donor":{"fullName":"Test Donor","email":"donor@test.com","location":{"city":"Test City","governorate":"Test Governorate","coordinates":{"lat":30.0444,"lng":31.2357}},"bloodType":"O+"}},{"_id":"6a1c65449e47c667314749f7","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:43:53.994Z","donor":{"fullName":"Test Donor 57905","email":"donor57905_1780245828728@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:43:48.728Z"},"bloodType":"O+"}},{"_id":"6a1c6567d24c70a3fb95a853","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:44:28.952Z","donor":{"fullName":"Test Donor 93259","email":"donor93259_1780245863532@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:44:23.532Z"},"bloodType":"O+"}},{"_id":"6a24e79cff4991d86a0c7dfc","completedDonations":1,"totalUnits":1,"lastDonation":"2026-06-07T03:38:11.373Z","donor":{"fullName":"Test Donor 38401","email":"donor38401_1780803484887@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-06-07T03:38:04.887Z"},"bloodType":"O+"}}]}

class TopDonorsModel {
  TopDonorsModel({
      this.success, 
      this.message, 
      this.data,});

  TopDonorsModel.fromJson(dynamic json) {
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

/// topDonors : [{"_id":"6a130e810b339a45a51addaf","completedDonations":3,"totalUnits":3,"lastDonation":"2026-06-04T07:00:00.000Z","donor":{"fullName":"Mariam Adel","email":"mariam.adel@lifelink.demo","location":{"city":"Nasr City","governorate":"Cairo","coordinates":{"lat":30.0637,"lng":31.3303},"lastUpdated":"2026-06-07T03:40:10.221Z"},"bloodType":"B+"}},{"_id":"6a1c6445a3e567d226796e4e","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:39:39.802Z","donor":{"fullName":"Test Donor 85727","email":"donor85727_1780245573800@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:39:33.800Z"},"bloodType":"O+"}},{"_id":"6a1a03f485d2cd97a5b5c070","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-19T21:24:05.023Z","donor":{"fullName":"Test Donor","email":"donor@test.com","location":{"city":"Test City","governorate":"Test Governorate","coordinates":{"lat":30.0444,"lng":31.2357}},"bloodType":"O+"}},{"_id":"6a1c65449e47c667314749f7","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:43:53.994Z","donor":{"fullName":"Test Donor 57905","email":"donor57905_1780245828728@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:43:48.728Z"},"bloodType":"O+"}},{"_id":"6a1c6567d24c70a3fb95a853","completedDonations":1,"totalUnits":1,"lastDonation":"2026-05-31T16:44:28.952Z","donor":{"fullName":"Test Donor 93259","email":"donor93259_1780245863532@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-05-31T16:44:23.532Z"},"bloodType":"O+"}},{"_id":"6a24e79cff4991d86a0c7dfc","completedDonations":1,"totalUnits":1,"lastDonation":"2026-06-07T03:38:11.373Z","donor":{"fullName":"Test Donor 38401","email":"donor38401_1780803484887@test.com","location":{"city":"Cairo","governorate":"Cairo","coordinates":{"lat":30.0444,"lng":31.2357},"lastUpdated":"2026-06-07T03:38:04.887Z"},"bloodType":"O+"}}]

class Data {
  Data({
      this.topDonors,});

  Data.fromJson(dynamic json) {
    if (json['topDonors'] != null) {
      topDonors = [];
      json['topDonors'].forEach((v) {
        topDonors?.add(TopDonors.fromJson(v));
      });
    }
  }
  List<TopDonors>? topDonors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (topDonors != null) {
      map['topDonors'] = topDonors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6a130e810b339a45a51addaf"
/// completedDonations : 3
/// totalUnits : 3
/// lastDonation : "2026-06-04T07:00:00.000Z"
/// donor : {"fullName":"Mariam Adel","email":"mariam.adel@lifelink.demo","location":{"city":"Nasr City","governorate":"Cairo","coordinates":{"lat":30.0637,"lng":31.3303},"lastUpdated":"2026-06-07T03:40:10.221Z"},"bloodType":"B+"}

class TopDonors {
  TopDonors({
      this.id, 
      this.completedDonations, 
      this.totalUnits, 
      this.lastDonation, 
      this.donor,});

  TopDonors.fromJson(dynamic json) {
    id = json['_id'];
    completedDonations = json['completedDonations'];
    totalUnits = json['totalUnits'];
    lastDonation = json['lastDonation'];
    donor = json['donor'] != null ? Donor.fromJson(json['donor']) : null;
  }
  String? id;
  int? completedDonations;
  int? totalUnits;
  String? lastDonation;
  Donor? donor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['completedDonations'] = completedDonations;
    map['totalUnits'] = totalUnits;
    map['lastDonation'] = lastDonation;
    if (donor != null) {
      map['donor'] = donor?.toJson();
    }
    return map;
  }

}

/// fullName : "Mariam Adel"
/// email : "mariam.adel@lifelink.demo"
/// location : {"city":"Nasr City","governorate":"Cairo","coordinates":{"lat":30.0637,"lng":31.3303},"lastUpdated":"2026-06-07T03:40:10.221Z"}
/// bloodType : "B+"

class Donor {
  Donor({
      this.fullName, 
      this.email, 
      this.location, 
      this.bloodType,});

  Donor.fromJson(dynamic json) {
    fullName = json['fullName'];
    email = json['email'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    bloodType = json['bloodType'];
  }
  String? fullName;
  String? email;
  Location? location;
  String? bloodType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['bloodType'] = bloodType;
    return map;
  }

}

/// city : "Nasr City"
/// governorate : "Cairo"
/// coordinates : {"lat":30.0637,"lng":31.3303}
/// lastUpdated : "2026-06-07T03:40:10.221Z"

class Location {
  Location({
      this.city, 
      this.governorate, 
      this.coordinates, 
      this.lastUpdated,});

  Location.fromJson(dynamic json) {
    city = json['city'];
    governorate = json['governorate'];
    coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    lastUpdated = json['lastUpdated'];
  }
  String? city;
  String? governorate;
  Coordinates? coordinates;
  String? lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['governorate'] = governorate;
    if (coordinates != null) {
      map['coordinates'] = coordinates?.toJson();
    }
    map['lastUpdated'] = lastUpdated;
    return map;
  }

}

/// lat : 30.0637
/// lng : 31.3303

class Coordinates {
  Coordinates({
      this.lat, 
      this.lng,});

  Coordinates.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}