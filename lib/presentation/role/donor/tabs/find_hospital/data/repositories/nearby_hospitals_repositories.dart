import '../model/nearby_hospitals.dart';

abstract class NearbyHospitalsRepositories {

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
  });
  Future<NearbyHospitals> searchNearbyHospitals({
    required String query,
    String? bloodType,
    bool? availableOnly,
    int page = 1,
    int limit = 10,
  });
}