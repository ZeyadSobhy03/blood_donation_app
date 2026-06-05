import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/donation_eligibility_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donation_eligibility/donation_eligibility_repositories.dart';

import '../../data_source/donation_eligibility/donation_eligibility_remote_data_source.dart';

class DonationEligibilityRepositoriesImp implements DonationEligibilityRepositories {
  final DonationEligibilityRemoteDataSource remoteDataSource;
  DonationEligibilityRepositoriesImp({required this.remoteDataSource});

  @override
  Future<DonationEligibilityModel> fetchDonationEligibility() {
    return remoteDataSource.fetchDonationEligibility();
  }


}