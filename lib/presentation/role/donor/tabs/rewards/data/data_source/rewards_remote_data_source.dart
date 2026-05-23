import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/badges_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/earning_rules_models.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_history.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/redeem_reward.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/rewards_model.dart';

abstract class RewardsRemoteDataSource {
  Future<BadgesModel> getBadges();
  Future<RewardsModel>getRewards();
  Future<RedeemReward>redeemReward({required String rewardId});
  Future<PointsModel>getUserPoints();
  Future<PointsHistory>getPointsHistory();
  Future<EarningRulesModels>getEarningRules();
}
