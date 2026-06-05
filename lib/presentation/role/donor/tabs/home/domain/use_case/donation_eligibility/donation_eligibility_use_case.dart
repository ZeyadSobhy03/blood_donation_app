import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donation_eligibility/donation_eligibility_repositories.dart';

import '../../../data/model/donation_eligibility/donation_eligibility_model.dart';

class DonationEligibilityUseCase {

  final DonationEligibilityRepositories repository;
  DonationEligibilityUseCase({required this.repository});
  Future<DonationEligibilityModel> fetchDonationEligibility(){
    return repository.fetchDonationEligibility();
  }

}