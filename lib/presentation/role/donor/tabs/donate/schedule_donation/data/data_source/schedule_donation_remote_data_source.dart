import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/nearby_hospital_model.dart';

abstract class ScheduleDonationRemoteDataSource {

  Future<NearbyHospitalModel> getNearbyHospitals(double latitude, double longitude,double radius);
}