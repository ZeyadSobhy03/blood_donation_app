import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/top_donor/top_donor_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/repositories/top_donor/top_donors_repositories.dart';

import '../../data_source/remote/top_donor/top_donors_remote_data_source.dart';

class TopDonorsRepositoriesImp implements TopDonorsRepositories {
  final TopDonorsRemoteDataSource topDonorsRemoteDataSource;

  TopDonorsRepositoriesImp({required this.topDonorsRemoteDataSource});

  @override
  Future<TopDonorsModel> getTopDonors() {
    return topDonorsRemoteDataSource.getTopDonors();
  }
}
