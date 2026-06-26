import '../model/admin_rewards_data_model.dart';
import '../model/earning_rule_create_model.dart';
import '../model/earning_rule_deleted_model.dart';
import '../model/earning_rule_model.dart';
import '../model/earning_rule_updated_model.dart';
import '../model/points_adjusted_model.dart';
import '../model/reward_create_model.dart';
import '../model/rewards_points_update_model.dart';
import '../model/rewards_status_update_model.dart';

abstract class AdminRewardsRepositories {
  Future<AdminRewardsDataModel> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  });
  Future<RewardCreateModel> createReward({
    required String rewardName,
    required String rewardSubtitle,
    required String category,
    required String status,

    required int pointsRequired,
  });
  Future<RewardsStatusUpdateModel> updateRewardStatus({
    required String rewardId,
    required String status,
  });
  Future<RewardsPointsUpdateModel> updateRewardPoints({
    required List<Map<String, dynamic>> updates,
  });
  Future<PointsAdjustedModel> adjustPoints({
    required String email,
    required int amount,
    required String reason,
  });
  Future<EarningRuleCreateModel> createEarningRule({
    required String type,
    required String title,
    required int points,
    required String category,
    required bool isActive,
  });

  Future<EarningRuleDeletedModel> deleteEarningRule({required String id});

  Future<EarningRuleModel> getEarningRules();

  Future<EarningRuleUpdatedModel> updateEarningRule({
    required String id,

    required int points,
  });
}