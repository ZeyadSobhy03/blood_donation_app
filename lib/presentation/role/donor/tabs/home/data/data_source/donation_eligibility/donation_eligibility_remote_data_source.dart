import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/donation_eligibility_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/participation_preference_model.dart';

abstract class DonationEligibilityRemoteDataSource {
  Future<DonationEligibilityModel> fetchDonationEligibility();
  Future<ParticipationPreferenceModel> setParticipation({required bool participation});


}