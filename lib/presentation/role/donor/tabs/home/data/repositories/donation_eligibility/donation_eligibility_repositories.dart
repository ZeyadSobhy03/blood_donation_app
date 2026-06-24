import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/participation_preference_model.dart';

import '../../model/donation_eligibility/donation_eligibility_model.dart';

abstract class DonationEligibilityRepositories {
  Future<DonationEligibilityModel> fetchDonationEligibility();
  Future<ParticipationPreferenceModel> setParticipation({required bool participation});


}