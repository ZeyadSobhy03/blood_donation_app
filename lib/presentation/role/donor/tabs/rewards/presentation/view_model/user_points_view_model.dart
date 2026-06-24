import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/model/points_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/rewards_use_case.dart';

class UserPointsCubit extends Cubit<UserPointsState> {
  final RewardsUseCase rewardsUseCase;
  UserPointsCubit({required this.rewardsUseCase})
      : super(UserPointsInitialState());

  Future<void> fetchUserPoints() async {
    try {
      emit(UserPointsLoadingState());
      final result = await rewardsUseCase.getUserPoints();
      if (result.success == true && result.data != null) {
        emit(UserPointsSuccessState(result));
      } else {
        emit(UserPointsErrorState('server_error'));
      }
    } on NetworkTimeoutException {
      emit(UserPointsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(UserPointsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(UserPointsErrorState('unauthorized'));
    } on NotFoundException {
      emit(UserPointsErrorState('not_found'));
    } on RequestCancelledException {
      emit(UserPointsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(UserPointsErrorState('unknown_error'));
    } catch (e) {
      emit(UserPointsErrorState('unknown_error'));
    }
  }


}
sealed class UserPointsState {}
class UserPointsInitialState extends UserPointsState {}
class UserPointsLoadingState extends UserPointsState {}
class UserPointsSuccessState extends UserPointsState {
  final PointsModel pointsModel;
  UserPointsSuccessState(this.pointsModel);
}
class UserPointsErrorState extends UserPointsState {
  final String error;
  UserPointsErrorState(this.error);
}