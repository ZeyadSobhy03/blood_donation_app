import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/repositories/rewards_repositories.dart';

import '../../data/model/badges_model.dart';
import '../../data/model/earning_rules_models.dart';
import '../../data/model/points_history.dart';
import '../../data/model/points_model.dart';
import '../../data/model/redeem_reward.dart';
import '../../data/model/rewards_model.dart';

class RewardsUseCase {
  final RewardsRepositories repository;
  RewardsUseCase({required this.repository});
  Future<BadgesModel> getBadges() {
    return repository.getBadges();
  }
  Future<RewardsModel>getRewards(){
    return repository.getRewards();
  }
  Future<RedeemReward>redeemReward({required String rewardId}){
    return repository.redeemReward(rewardId: rewardId);
  }
  Future<PointsModel>getUserPoints(){
    return repository.getUserPoints();
  }
  Future<PointsHistory>getPointsHistory(){
    return repository.getPointsHistory();
  }
  Future<EarningRulesModels>getEarningRules(){
    return repository.getEarningRules();
  }

}