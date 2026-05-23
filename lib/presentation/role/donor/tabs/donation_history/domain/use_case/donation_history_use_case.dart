import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/repositories/donation_history_repositories.dart';

import '../../data/model/donation_history_model.dart';

class DonationHistoryUseCase {
  final DonationHistoryRepositories repository;

  DonationHistoryUseCase({required this.repository});

  Future<DonationHistoryModel> fetchDonationHistory({
    required int page,
    required int limit,
  }) async {
    return await repository.fetchDonationHistory(page: page, limit: limit);
  }
}
