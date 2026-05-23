import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/badges_model.dart';
import '../../data/model/points_model.dart';
import '../../data/model/rewards_model.dart';
import '../../domain/use_case/rewards_use_case.dart';

class RewardsCubit extends Cubit<RewardsState> {
  final RewardsUseCase rewardsUseCase;

  RewardsCubit({required this.rewardsUseCase}) : super(RewardsInitialState());

  Future<void> fetchBadges() async {
    try {
      emit(RewardsLoadingState());
      final badges = await rewardsUseCase.getBadges();
      emit(BadgesSuccessState(badges));
    } catch (e) {
      emit(RewardsErrorState(e.toString()));
    }
  }

  Future<void> fetchRewards() async {
    try {
      emit(RewardsLoadingState());
      final rewards = await rewardsUseCase.getRewards();
      emit(RewardsSuccessState(rewards));
    } catch (e) {
      emit(RewardsErrorState(e.toString()));
    }
  }

  Future<void> redeemReward(String rewardId, int pointsCost) async {
    try {
      emit(RewardsLoadingState());
      await rewardsUseCase.redeemReward(rewardId: rewardId);
      emit(RedeemSuccessState("Reward redeemed successfully!"));
    } catch (e) {
      emit(RewardsErrorState(e.toString()));
    }
  }

  Future<void> fetchUserPoints() async {
    try {
      final points = await rewardsUseCase.getUserPoints();
      emit(UserPointsUpdatedState(points));
    } catch (e) {
      emit(UserPointsErrorState(e.toString()));
    }
  }


}

sealed class RewardsState {}

class RewardsInitialState extends RewardsState {}

class RewardsLoadingState extends RewardsState {}

class BadgesSuccessState extends RewardsState {
  final BadgesModel badges;

  BadgesSuccessState(this.badges);
}

class RewardsSuccessState extends RewardsState {
  final RewardsModel rewards;

  RewardsSuccessState(this.rewards);
}

class RedeemSuccessState extends RewardsState {
  final String message;

  RedeemSuccessState(this.message);
}

class UserPointsUpdatedState extends RewardsState {
  final PointsModel points;

  UserPointsUpdatedState(this.points);
}

class UserPointsErrorState extends RewardsState {
  final String message;

  UserPointsErrorState(this.message);
}

class RewardsErrorState extends RewardsState {
  final String message;

  RewardsErrorState(this.message);
}


