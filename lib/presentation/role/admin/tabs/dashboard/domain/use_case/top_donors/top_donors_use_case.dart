import '../../../data/model/top_donor/top_donor_model.dart';
import '../../../data/repositories/top_donor/top_donors_repositories.dart';

class TopDonorsUseCase {

  final TopDonorsRepositories topDonorsRepositories;
  TopDonorsUseCase({required this.topDonorsRepositories});
  Future<TopDonorsModel > getTopDonors() {
    return topDonorsRepositories.getTopDonors();
  }
}