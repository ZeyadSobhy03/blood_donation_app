import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
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
    } on NetworkTimeoutException {
      emit(RewardsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(RewardsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RewardsErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(RewardsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RewardsErrorState('unknown_error'));
    } catch (e) {
      emit(RewardsErrorState('unknown_error'));
    }
  }

  Future<void> fetchRewards() async {
    try {
      emit(RewardsLoadingState());
      final rewards = await rewardsUseCase.getRewards();
      emit(RewardsSuccessState(rewards));
    } on NetworkTimeoutException {
      emit(RewardsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(RewardsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RewardsErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(RewardsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RewardsErrorState('unknown_error'));
    } catch (e) {
      emit(RewardsErrorState('unknown_error'));
    }
  }

  Future<void> redeemReward(String rewardId, int pointsCost) async {
    try {
      emit(RewardsLoadingState());
      await rewardsUseCase.redeemReward(rewardId: rewardId);
      emit(RedeemSuccessState("reward_redeemed_successfully"));
    } on NetworkTimeoutException {
      emit(RewardsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(RewardsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RewardsErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(RewardsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RewardsErrorState('unknown_error'));
    } catch (e) {
      emit(RewardsErrorState('unknown_error'));
    }
  }

  Future<void> fetchUserPoints() async {
    try {
      final points = await rewardsUseCase.getUserPoints();
      emit(UserPointsUpdatedState(points));
    } on NetworkTimeoutException {
      emit(UserPointsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(UserPointsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(UserPointsErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(UserPointsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(UserPointsErrorState('unknown_error'));
    } catch (e) {
      emit(UserPointsErrorState('unknown_error'));
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


