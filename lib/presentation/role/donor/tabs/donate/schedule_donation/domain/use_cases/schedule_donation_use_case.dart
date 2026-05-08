import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/schedule_donation_repositories.dart';

import '../../data/models/nearby_hospital_model.dart';

class ScheduleDonationUseCase {

  ScheduleDonationRepositories scheduleDonationRepositories;
  ScheduleDonationUseCase({required this.scheduleDonationRepositories});
  Future<NearbyHospitalModel> getNearbyHospitals(double latitude, double longitude,double radius) async {
    return await scheduleDonationRepositories.getNearbyHospitals(latitude, longitude, radius);
  }

}