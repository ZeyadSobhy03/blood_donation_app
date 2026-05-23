import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/repositories/nearby_hospitals_repositories.dart';

import '../../data/model/nearby_hospitals.dart';

class NearbyHospitalsUseCase {
  NearbyHospitalsRepositories nearbyHospitalsRepositories;

  NearbyHospitalsUseCase({required this.nearbyHospitalsRepositories});

  Future<NearbyHospitals> getNearbyHospitals({
    required double latitude,
    required double longitude,
    double radius = 10,
    String? search,
    String? bloodType,
    String sortBy = 'distance',
    String order = 'asc',
    int page = 1,
    int limit = 10,
  }) {
    return nearbyHospitalsRepositories.getNearbyHospitals(
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      search: search,
      bloodType: bloodType,
      sortBy: sortBy,
      order: order,
      page: page,
      limit: limit,
    );
  }

  Future<NearbyHospitals> searchNearbyHospitals({
    required String query,
    String? bloodType,
    bool? availableOnly,
    int page = 1,
    int limit = 10,
  }) {
    return nearbyHospitalsRepositories.searchNearbyHospitals(
      query: query,
      bloodType: bloodType,
      availableOnly: availableOnly,
      page: page,
      limit: limit,
    );
  }
}
