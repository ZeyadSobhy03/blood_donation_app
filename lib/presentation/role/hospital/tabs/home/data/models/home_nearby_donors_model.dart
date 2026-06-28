/// Model for GET /hospital/nearby-donors?groupBy=bloodType
///
/// Example response:
/// {
///   "success": true,
///   "message": "Nearby donor groups retrieved successfully",
///   "data": {
///     "groups": [
///       { "bloodType": "A-", "count": 2, "nearestDistanceKm": 4.5 },
///       { "bloodType": "O+", "count": 5, "nearestDistanceKm": 2.3 }
///     ]
///   }
/// }
class HomeNearbyDonorsModel {
  HomeNearbyDonorsModel({this.success, this.message, this.data});

  HomeNearbyDonorsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? HomeNearbyDonorsData.fromJson(json['data'])
        : null;
  }

  bool? success;
  String? message;
  HomeNearbyDonorsData? data;
}

class HomeNearbyDonorsData {
  HomeNearbyDonorsData({this.groups});

  HomeNearbyDonorsData.fromJson(dynamic json) {
    if (json['groups'] is List) {
      groups = (json['groups'] as List)
          .map((e) => BloodTypeDonorGroup.fromJson(e))
          .toList();
    }
  }

  List<BloodTypeDonorGroup>? groups;
}

class BloodTypeDonorGroup {
  BloodTypeDonorGroup({this.bloodType, this.count, this.nearestDistanceKm});

  BloodTypeDonorGroup.fromJson(dynamic json) {
    bloodType = json['bloodType'];
    count = (json['count'] as num?)?.toInt();
    nearestDistanceKm = (json['nearestDistanceKm'] as num?)?.toDouble();
  }

  String? bloodType;
  int? count;
  double? nearestDistanceKm;

  /// Display string e.g. "2.3 km"
  String get nearestDistanceDisplay =>
      nearestDistanceKm != null ? '${nearestDistanceKm!.toStringAsFixed(1)} km' : '';
}
