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
        emit(UserPointsErrorState('Failed to load points'));
      }
    } catch (e) {
      emit(UserPointsErrorState(e.toString()));
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