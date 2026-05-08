import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/schedule_donation_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/nearby_hospital_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/schedule_donation_repositories.dart';

class ScheduleDonationRepositoriesImp implements ScheduleDonationRepositories {
  ScheduleDonationRemoteDataSource scheduleDonationRemoteDataSource;

  ScheduleDonationRepositoriesImp({
    required this.scheduleDonationRemoteDataSource,
  });

  @override
  Future<NearbyHospitalModel> getNearbyHospitals(
    double latitude,
    double longitude,
      double radius,
  ) async {
    return await scheduleDonationRemoteDataSource.getNearbyHospitals(
      latitude,
      longitude,
      radius
    );
  }
}
