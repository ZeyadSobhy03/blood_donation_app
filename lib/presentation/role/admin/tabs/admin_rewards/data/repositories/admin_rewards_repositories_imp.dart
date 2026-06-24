import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/repositories/admin_rewards_repositories.dart';

import '../data_source/admin_rewards_remote_data_source.dart';

class AdminRewardsRepositoriesImp implements AdminRewardsRepositories{
  final AdminRewardsRemoteDataSource adminRewardsRemoteDataSource;
  AdminRewardsRepositoriesImp({required this.adminRewardsRemoteDataSource});

  @override
  Future<AdminRewardsDataModel> getAdminRewardsData({String? query, int? limit, int? adjustments}) {
    return adminRewardsRemoteDataSource.getAdminRewardsData(query: query, limit: limit, adjustments: adjustments);
  }

}