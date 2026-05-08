import '../models/nearby_hospital_model.dart';

abstract class ScheduleDonationRepositories {
  Future<NearbyHospitalModel> getNearbyHospitals(double latitude, double longitude,double radius);

}