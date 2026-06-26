import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/repositories/admin_rewards_repositories.dart';

import '../../data/model/admin_rewards_data_model.dart';
import '../../data/model/earning_rule_create_model.dart';
import '../../data/model/earning_rule_deleted_model.dart';
import '../../data/model/earning_rule_model.dart';
import '../../data/model/earning_rule_updated_model.dart';
import '../../data/model/points_adjusted_model.dart';
import '../../data/model/reward_create_model.dart';
import '../../data/model/rewards_points_update_model.dart';
import '../../data/model/rewards_status_update_model.dart';

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
  Future<RewardCreateModel> createReward({
    required String rewardName,
    required String rewardSubtitle,
    required String category,
    required String status,

    required int pointsRequired,
  }){
    return adminRewardsRepositories.createReward(
      rewardName: rewardName,
      rewardSubtitle: rewardSubtitle,
      category: category,
      status: status,
      pointsRequired: pointsRequired,
    );
  }
  Future<RewardsStatusUpdateModel> updateRewardStatus({
    required String rewardId,
    required String status,
  }){
    return adminRewardsRepositories.updateRewardStatus(
      rewardId: rewardId,
      status: status,
    );
  }
  Future<RewardsPointsUpdateModel> updateRewardPoints({
    required List<Map<String, dynamic>> updates,
  }){
    return adminRewardsRepositories.updateRewardPoints(
      updates: updates,
    );
  }
  Future<PointsAdjustedModel> adjustPoints({
    required String email,
    required int amount,
    required String reason,
  }){
    return adminRewardsRepositories.adjustPoints(
      email: email,
      amount: amount,
      reason: reason,
    );
  }
  Future<EarningRuleCreateModel> createEarningRule({
    required String type,
    required String title,
    required int points,
    required String category,
    required bool isActive,
  }){
    return adminRewardsRepositories.createEarningRule(
      type: type,
      title: title,
      points: points,
      category: category,
      isActive: isActive,
    );
  }

  Future<EarningRuleDeletedModel> deleteEarningRule({required String id}){
    return adminRewardsRepositories.deleteEarningRule(id: id);
  }

  Future<EarningRuleModel> getEarningRules(){
    return adminRewardsRepositories.getEarningRules();
  }

  Future<EarningRuleUpdatedModel> updateEarningRule({
    required String id,

    required int points,
  }){
    return adminRewardsRepositories.updateEarningRule(
      id: id,
      points: points,
    );
  }

}