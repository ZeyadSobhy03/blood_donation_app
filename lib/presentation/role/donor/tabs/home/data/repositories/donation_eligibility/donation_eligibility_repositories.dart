import '../../model/donation_eligibility/donation_eligibility_model.dart';

abstract class DonationEligibilityRepositories {
  Future<DonationEligibilityModel> fetchDonationEligibility();

}