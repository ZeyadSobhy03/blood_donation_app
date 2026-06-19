class AnalyticsModel {
  AnalyticsModel({this.success, this.message, this.data});

  AnalyticsModel.fromJson(dynamic json) {
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
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class Data {
  Data({
    this.totalDonors,
    this.totalDonorsGrowth,
    this.activeRequests,
    this.activeRequestsGrowth,
    this.criticalCases,
    this.criticalCasesGrowth,
    this.successfulDonations,
    this.successfulDonationsGrowth,
    this.weeklyTrends,
    this.criticalAlerts,
    this.bloodTypeDistribution,
    this.topDonors,
    this.aiInsights,
  });

  Data.fromJson(dynamic json) {
    totalDonors = json['totalDonors'];
    totalDonorsGrowth = json['totalDonorsGrowth'];
    activeRequests = json['activeRequests'];
    activeRequestsGrowth = json['activeRequestsGrowth'];
    criticalCases = json['criticalCases'];
    criticalCasesGrowth = json['criticalCasesGrowth'];
    successfulDonations = json['successfulDonations'];
    successfulDonationsGrowth = json['successfulDonationsGrowth'];
    weeklyTrends = json['weeklyTrends'] != null
        ? WeeklyTrends.fromJson(json['weeklyTrends'])
        : null;
    if (json['criticalAlerts'] != null) {
      criticalAlerts = [];
      json['criticalAlerts'].forEach((v) {
        criticalAlerts?.add(CriticalAlertModel.fromJson(v));
      });
    }
    bloodTypeDistribution = json['bloodTypeDistribution'] != null
        ? BloodTypeDistribution.fromJson(json['bloodTypeDistribution'])
        : null;
    if (json['topDonors'] != null) {
      topDonors = [];
      json['topDonors'].forEach((v) {
        topDonors?.add(TopDonors.fromJson(v));
      });
    }
    if (json['aiInsights'] != null) {
      aiInsights = [];
      json['aiInsights'].forEach((v) {
        aiInsights?.add(AiInsights.fromJson(v));
      });
    }
  }

  int? totalDonors;
  String? totalDonorsGrowth;
  int? activeRequests;
  String? activeRequestsGrowth;
  int? criticalCases;
  String? criticalCasesGrowth;
  int? successfulDonations;
  String? successfulDonationsGrowth;
  WeeklyTrends? weeklyTrends;
  List<CriticalAlertModel>? criticalAlerts;
  BloodTypeDistribution? bloodTypeDistribution;
  List<TopDonors>? topDonors;
  List<AiInsights>? aiInsights;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalDonors'] = totalDonors;
    map['totalDonorsGrowth'] = totalDonorsGrowth;
    map['activeRequests'] = activeRequests;
    map['activeRequestsGrowth'] = activeRequestsGrowth;
    map['criticalCases'] = criticalCases;
    map['criticalCasesGrowth'] = criticalCasesGrowth;
    map['successfulDonations'] = successfulDonations;
    map['successfulDonationsGrowth'] = successfulDonationsGrowth;
    if (weeklyTrends != null) map['weeklyTrends'] = weeklyTrends?.toJson();
    if (criticalAlerts != null) {
      map['criticalAlerts'] = criticalAlerts?.map((v) => v.toJson()).toList();
    }
    if (bloodTypeDistribution != null) {
      map['bloodTypeDistribution'] = bloodTypeDistribution?.toJson();
    }
    if (topDonors != null) {
      map['topDonors'] = topDonors?.map((v) => v.toJson()).toList();
    }
    if (aiInsights != null) {
      map['aiInsights'] = aiInsights?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AiInsights {
  AiInsights({this.title, this.description, this.confidence});

  AiInsights.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    confidence = json['confidence'];
  }

  String? title;
  String? description;
  int? confidence;

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'confidence': confidence,
  };
}

class TopDonors {
  TopDonors({
    this.id, this.name, this.email, this.phoneNumber, this.bloodType,
    this.totalDonations, this.points, this.isEligibleToDonate,
    this.isActive, this.isVerified, this.location, this.gender,
    this.age, this.weight, this.healthStatus, this.isBanned,
    this.donorRank, this.createdAt,
  });

  TopDonors.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    bloodType = json['bloodType'];
    totalDonations = json['totalDonations'];
    points = json['points'];
    isEligibleToDonate = json['isEligibleToDonate'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    weight = json['weight'];
    healthStatus = json['healthStatus'];
    isBanned = json['isBanned'];
    donorRank = json['donorRank'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? bloodType;
  int? totalDonations;
  int? points;
  bool? isEligibleToDonate;
  bool? isActive;
  bool? isVerified;
  String? location;
  String? gender;
  dynamic age;
  dynamic weight;
  String? healthStatus;
  bool? isBanned;
  int? donorRank;
  String? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'email': email,
    'phoneNumber': phoneNumber, 'bloodType': bloodType,
    'totalDonations': totalDonations, 'points': points,
    'isEligibleToDonate': isEligibleToDonate, 'isActive': isActive,
    'isVerified': isVerified, 'location': location, 'gender': gender,
    'age': age, 'weight': weight, 'healthStatus': healthStatus,
    'isBanned': isBanned, 'donorRank': donorRank, 'createdAt': createdAt,
  };
}

class BloodTypeDistribution {
  BloodTypeDistribution({
    this.aPos, this.aNeg,
    this.bPos, this.bNeg,
    this.abPos, this.abNeg,
    this.oPos, this.oNeg,
  });

  BloodTypeDistribution.fromJson(dynamic json) {
    aPos  = json['A+'];
    aNeg  = json['A-'];
    bPos  = json['B+'];
    bNeg  = json['B-'];
    abPos = json['AB+'];
    abNeg = json['AB-'];
    oPos  = json['O+'];
    oNeg  = json['O-'];
  }

  int? aPos;
  int? aNeg;
  int? bPos;
  int? bNeg;
  int? abPos;
  int? abNeg;
  int? oPos;
  int? oNeg;

  Map<String, dynamic> toJson() => {
    'A+': aPos, 'A-': aNeg,
    'B+': bPos, 'B-': bNeg,
    'AB+': abPos, 'AB-': abNeg,
    'O+': oPos, 'O-': oNeg,
  };
}

class CriticalAlertModel {
  CriticalAlertModel({
    this.id, this.title, this.type, this.description, this.unitsNeeded,
    this.bloodTypesNeeded, this.hospitalId, this.hospitalName,
    this.hospitalContact, this.location, this.latitude, this.longitude,
    this.predictMatchPercentage, this.date, this.createdAt,
  });

  CriticalAlertModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    unitsNeeded = json['unitsNeeded'];
    bloodTypesNeeded = json['bloodTypesNeeded'] != null
        ? json['bloodTypesNeeded'].cast<String>()
        : [];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
    hospitalContact = json['hospitalContact'];
    location = json['location'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    predictMatchPercentage = json['predictMatchPercentage'];
    date = json['date'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? title;
  String? type;
  String? description;
  int? unitsNeeded;
  List<String>? bloodTypesNeeded;
  String? hospitalId;
  String? hospitalName;
  String? hospitalContact;
  String? location;
  double? latitude;
  double? longitude;
  int? predictMatchPercentage;
  String? date;
  String? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'type': type,
    'description': description, 'unitsNeeded': unitsNeeded,
    'bloodTypesNeeded': bloodTypesNeeded, 'hospitalId': hospitalId,
    'hospitalName': hospitalName, 'hospitalContact': hospitalContact,
    'location': location, 'latitude': latitude, 'longitude': longitude,
    'predictMatchPercentage': predictMatchPercentage,
    'date': date, 'createdAt': createdAt,
  };
}

class WeeklyTrends {
  WeeklyTrends({this.values, this.labels});

  WeeklyTrends.fromJson(dynamic json) {
    values = json['values'] != null ? json['values'].cast<int>() : [];
    labels = json['labels'] != null ? json['labels'].cast<String>() : [];
  }

  List<int>? values;
  List<String>? labels;

  Map<String, dynamic> toJson() => {
    'values': values,
    'labels': labels,
  };
}