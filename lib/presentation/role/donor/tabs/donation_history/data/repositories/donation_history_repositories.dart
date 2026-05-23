import '../model/donation_history_model.dart';

abstract class DonationHistoryRepositories {

  Future<DonationHistoryModel> fetchDonationHistory({
    required int page ,
    required int limit,
  });

}