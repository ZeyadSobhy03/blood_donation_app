import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/badges_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/earning_rules_models.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_history.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/redeem_reward.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/rewards_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/repositories/rewards_repositories.dart';

import '../data_source/rewards_remote_data_source.dart';

class RewardsRepositoriesImp  implements RewardsRepositories{
  final  RewardsRemoteDataSource rewardsRemoteDataSource;
  RewardsRepositoriesImp({required this.rewardsRemoteDataSource});
  @override
  Future<BadgesModel> getBadges() {
    return rewardsRemoteDataSource.getBadges();
  }

  @override
  Future<RewardsModel> getRewards() {
    return rewardsRemoteDataSource.getRewards();
  }

  @override
  Future<RedeemReward> redeemReward({required String rewardId}) {
    return rewardsRemoteDataSource.redeemReward(rewardId: rewardId);
  }

  @override
  Future<PointsModel> getUserPoints() {
    return rewardsRemoteDataSource.getUserPoints();
  }

  @override
  Future<PointsHistory> getPointsHistory() {
    return rewardsRemoteDataSource.getPointsHistory();
  }

  @override
  Future<EarningRulesModels> getEarningRules() {
    return rewardsRemoteDataSource.getEarningRules();
  }

}