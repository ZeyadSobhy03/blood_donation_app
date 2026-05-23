import '../model/badges_model.dart';
import '../model/earning_rules_models.dart';
import '../model/points_history.dart';
import '../model/points_model.dart';
import '../model/redeem_reward.dart';
import '../model/rewards_model.dart';

abstract class RewardsRepositories {
  Future<BadgesModel> getBadges();
  Future<RewardsModel> getRewards();
  Future<RedeemReward> redeemReward({required String rewardId});
  Future<PointsModel>getUserPoints();
  Future<PointsHistory>getPointsHistory();
  Future<EarningRulesModels>getEarningRules();



}