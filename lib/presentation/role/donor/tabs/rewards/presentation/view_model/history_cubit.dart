import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/points_history.dart';
import '../../domain/use_case/rewards_use_case.dart';

class HistoryCubit  extends Cubit<HistoryState>{
  final RewardsUseCase rewardsUseCase;

  HistoryCubit({required this.rewardsUseCase}) : super(HistoryLoadingState());

  Future<void> fetchPointsHistory() async {
    try {
      emit(HistoryLoadingState());
      final pointsHistory = await rewardsUseCase.getPointsHistory();
      emit(HistorySuccessState(pointsHistory));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }
}
sealed class HistoryState {}
class HistoryLoadingState extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final PointsHistory pointsHistory;

  HistorySuccessState(this.pointsHistory);
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState(this.message);
}