import '../model/admin_rewards_data_model.dart';

abstract class AdminRewardsRepositories {
  Future<AdminRewardsDataModel> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  });
}