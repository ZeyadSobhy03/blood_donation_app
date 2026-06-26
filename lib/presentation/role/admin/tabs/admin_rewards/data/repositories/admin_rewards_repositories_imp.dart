import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_create_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_deleted_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/earning_rule_updated_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/points_adjusted_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/reward_create_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/rewards_points_update_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/rewards_status_update_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/repositories/admin_rewards_repositories.dart';

import '../data_source/admin_rewards_remote_data_source.dart';

class AdminRewardsRepositoriesImp implements AdminRewardsRepositories{
  final AdminRewardsRemoteDataSource adminRewardsRemoteDataSource;
  AdminRewardsRepositoriesImp({required this.adminRewardsRemoteDataSource});

  @override
  Future<AdminRewardsDataModel> getAdminRewardsData({String? query, int? limit, int? adjustments}) {
    return adminRewardsRemoteDataSource.getAdminRewardsData(query: query, limit: limit, adjustments: adjustments);
  }

  @override
  Future<PointsAdjustedModel> adjustPoints({required String email, required int amount, required String reason}) {
    return adminRewardsRemoteDataSource.adjustPoints(email: email, amount: amount, reason: reason);
  }

  @override
  Future<RewardCreateModel> createReward({required String rewardName, required String rewardSubtitle, required String category, required String status, required int pointsRequired}) {
    return adminRewardsRemoteDataSource.createReward(rewardName: rewardName, rewardSubtitle: rewardSubtitle, category: category, status: status, pointsRequired: pointsRequired);
  }

  @override
  Future<RewardsPointsUpdateModel> updateRewardPoints({required List<Map<String, dynamic>> updates}) {
    return adminRewardsRemoteDataSource.updateRewardPoints(updates: updates);
  }

  @override
  Future<RewardsStatusUpdateModel> updateRewardStatus({required String rewardId, required String status}) {
    return adminRewardsRemoteDataSource.updateRewardStatus(rewardId: rewardId, status: status);
  }

  @override
  Future<EarningRuleCreateModel> createEarningRule({required String type, required String title, required int points, required String category, required bool isActive}) {
    return adminRewardsRemoteDataSource.createEarningRule(type: type, title: title, points: points, category: category, isActive: isActive);
  }

  @override
  Future<EarningRuleDeletedModel> deleteEarningRule({required String id}) {
    return adminRewardsRemoteDataSource.deleteEarningRule(id: id);
  }

  @override
  Future<EarningRuleModel> getEarningRules() {
    return adminRewardsRemoteDataSource.getEarningRules();
  }

  @override
  Future<EarningRuleUpdatedModel> updateEarningRule({required String id, required int points}) {
    return adminRewardsRemoteDataSource.updateEarningRule(id: id, points: points);
  }

}