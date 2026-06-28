import 'package:blood_donation_app/core/resources/models/donor.dart';
import 'package:blood_donation_app/l10n/app_localizations_ar.dart';

class FindDonorsModel {
  FindDonorsModel({this.success, this.message, this.data});

  FindDonorsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? FindDonorsData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  FindDonorsData? data;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    if (data != null) 'data': data!.toJson(),
  };
}

class FindDonorsData {
  FindDonorsData({this.donors, this.pagination});

  FindDonorsData.fromJson(dynamic json) {
    if (json['donors'] != null && json['donors'] is List) {
      donors = (json['donors'] as List)
          .map((d) => NearbyDonor.fromJson(d))
          .toList();
    }
    pagination = json['pagination'] != null
        ? DonorPagination.fromJson(json['pagination'])
        : null;
  }

  List<NearbyDonor>? donors;
  DonorPagination? pagination;

  Map<String, dynamic> toJson() => {
    if (donors != null) 'donors': donors!.map((d) => d.toJson()).toList(),
    if (pagination != null) 'pagination': pagination!.toJson(),
  };
}

class NearbyDonor {
  NearbyDonor({
    this.donorId,
    this.fullName,
    this.email,
    this.bloodType,
    this.distanceKm,
    this.distanceMeters,
    this.isAvailable,
    this.phoneNumber,
    this.location,
  });

  NearbyDonor.fromJson(dynamic json) {
    donorId = json['donorId'];
    fullName = json['fullName'];
    email = json['email'];
    bloodType = json['bloodType'];
    distanceKm = (json['distanceKm'] as num?)?.toDouble();
    distanceMeters = json['distanceMeters'];
    isAvailable = json['isAvailable'];
    phoneNumber = json['phoneNumber'];
    location = json['location'] != null
        ? NearbyDonorLocation.fromJson(json['location'])
        : null;
  }

  String? donorId;
  String? fullName;
  String? email;
  String? bloodType;
  double? distanceKm;
  int? distanceMeters;
  bool? isAvailable;
  String? phoneNumber;
  NearbyDonorLocation? location;
  final AppLocalizationsAr loc = AppLocalizationsAr();

  Map<String, dynamic> toJson() => {
    'donorId': donorId,
    'fullName': fullName,
    'email': email,
    'bloodType': bloodType,
    'distanceKm': distanceKm,
    'distanceMeters': distanceMeters,
    'isAvailable': isAvailable,
    'phoneNumber': phoneNumber,
    if (location != null) 'location': location!.toJson(),
  };

  DonorModel toDonorModel({String? governorate}) {
    final locationLabel = (distanceKm != null
        ? loc.distanceAway(distanceKm.toString())
        : '');

    return DonorModel(
      id: donorId ?? '',
      name: fullName ?? '',
      email: email ?? '',
      phoneNumber: phoneNumber ?? '',
      bloodType: bloodType ?? '',
      totalDonations: 0,
      points: 0,
      isEligibleToDonate: isAvailable ?? false,
      location: locationLabel,
      isActive: isAvailable ?? false,
      isVerified: false,
      isBanned: false,
      isOnline: isAvailable ?? false,
      gender: '',
      age: 0,
      weight: 0,
      healthStatus: '',
      createdAt: DateTime.now(),
      latitude: location?.latitude,
      longitude: location?.longitude,
      distanceInKm: distanceKm,
      donorRank: 0,
    );
  }
}

class NearbyDonorLocation {
  NearbyDonorLocation({this.latitude, this.longitude});

  NearbyDonorLocation.fromJson(dynamic json) {
    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();
  }

  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

class DonorPagination {
  DonorPagination({this.page, this.limit, this.total, this.totalPages});

  DonorPagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  int? page;
  int? limit;
  int? total;
  int? totalPages;

  bool get hasNextPage => (page ?? 1) < (totalPages ?? 1);

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPages': totalPages,
  };
}