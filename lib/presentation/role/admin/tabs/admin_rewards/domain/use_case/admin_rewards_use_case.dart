import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/repositories/admin_rewards_repositories.dart';

import '../../data/model/admin_rewards_data_model.dart';

class AdminRewardsUseCase {
  final AdminRewardsRepositories adminRewardsRepositories;
  AdminRewardsUseCase({required this.adminRewardsRepositories});
  Future<AdminRewardsDataModel> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  }) async {
    return await adminRewardsRepositories.getAdminRewardsData(
      query: query,
      limit: limit,
      adjustments: adjustments,
    );
  }

}