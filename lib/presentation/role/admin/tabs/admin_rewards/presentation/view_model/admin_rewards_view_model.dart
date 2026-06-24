import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/errors/app_exceptions.dart';
import '../../data/model/admin_rewards_data_model.dart';
import '../../domain/use_case/admin_rewards_use_case.dart';

class AdminRewardsCubit extends Cubit<AdminRewardsState> {
  final AdminRewardsUseCase adminRewardsUseCase;

  AdminRewardsCubit({required this.adminRewardsUseCase})
    : super(AdminRewardsInitialState());

  AdminRewardsDataModel? _currentData;

  AdminRewardsDataModel? get currentData => _currentData;

  Future<void> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  }) async {
    emit(AdminRewardsLoadingState());
    try {
      final adminRewardsDataModel = await adminRewardsUseCase
          .getAdminRewardsData(
            query: query,
            limit: limit,
            adjustments: adjustments,
          );

      _currentData = adminRewardsDataModel;
      emit(AdminRewardsSuccessState(adminRewardsDataModel: _currentData!));
    } on NetworkTimeoutException {
      emit(AdminRewardsErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AdminRewardsErrorState(e.message ?? 'unauthorized'));
    } on ServerException catch (e) {
      emit(AdminRewardsErrorState(e.serverMessage ?? 'server_error'));
    } on NotFoundException {
      emit(AdminRewardsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AdminRewardsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AdminRewardsErrorState('unknown_error'));
    } catch (e) {
      emit(AdminRewardsErrorState('unknown_error'));
    }
  }
}

sealed class AdminRewardsState {}

class AdminRewardsInitialState extends AdminRewardsState {}

class AdminRewardsLoadingState extends AdminRewardsState {}

class AdminRewardsSuccessState extends AdminRewardsState {
  final AdminRewardsDataModel adminRewardsDataModel;

  AdminRewardsSuccessState({required this.adminRewardsDataModel});
}

class AdminRewardsErrorState extends AdminRewardsState {
  final String error;

  AdminRewardsErrorState(this.error);
}
