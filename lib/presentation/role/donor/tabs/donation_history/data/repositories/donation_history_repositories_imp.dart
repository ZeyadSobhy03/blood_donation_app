import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/model/donation_history_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/repositories/donation_history_repositories.dart';

import '../data_source/donation_history_remote_data_source.dart';

class DonationHistoryRepositoriesImp implements DonationHistoryRepositories {
  final DonationHistoryRemoteDataSource remoteDataSource;
  DonationHistoryRepositoriesImp({required this.remoteDataSource});

  @override
  Future<DonationHistoryModel> fetchDonationHistory({required int page, required int limit}) {
    return remoteDataSource.fetchDonationHistory(page: page, limit: limit);
  }

}