import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/errors/app_exceptions.dart';
import '../../data/model/admin_rewards_data_model.dart';
import '../../data/model/earning_rule_create_model.dart';
import '../../data/model/earning_rule_deleted_model.dart';
import '../../data/model/earning_rule_model.dart';
import '../../data/model/earning_rule_updated_model.dart';
import '../../data/model/points_adjusted_model.dart';
import '../../data/model/reward_create_model.dart';
import '../../data/model/rewards_points_update_model.dart';
import '../../data/model/rewards_status_update_model.dart';
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
      _currentData = await adminRewardsUseCase.getAdminRewardsData(
        query: query,
        limit: limit,
        adjustments: adjustments,
      );
      emit(AdminRewardsSuccessState(adminRewardsDataModel: _currentData!));
    } on NetworkTimeoutException {
      emit(AdminRewardsErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AdminRewardsErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AdminRewardsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AdminRewardsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AdminRewardsErrorState('request_cancelled'));
    } catch (e) {
      emit(AdminRewardsErrorState('unknown_error'));
    }
  }

  Future<void> createReward({
    required String rewardName,
    required String rewardSubtitle,
    required String category,
    required String status,
    required int pointsRequired,
  }) async {
    emit(RewardOperationLoadingState());
    try {
      final model = await adminRewardsUseCase.createReward(
        rewardName: rewardName,
        rewardSubtitle: rewardSubtitle,
        category: category,
        status: status,
        pointsRequired: pointsRequired,
      );
      emit(AdminRewardsCreateSuccessState(rewardCreateModel: model));
    } on NetworkTimeoutException {
      emit(RewardOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(RewardOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(RewardOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(RewardOperationErrorState('unknown_error'));
    }
  }

  Future<void> updateRewardStatus({
    required String rewardId,
    required String status,
  }) async {
    try {
      final model = await adminRewardsUseCase.updateRewardStatus(
        rewardId: rewardId,
        status: status,
      );
      if (_currentData?.data?.catalog != null) {
        final updatedItems = _currentData!.data!.catalog!.items
            ?.map(
              (item) =>
          item.id == rewardId ? item.copyWith(status: status) : item,
        )
            .toList();
        _currentData!.data!.catalog = _currentData!.data!.catalog!.copyWith(
          items: updatedItems,
        );
        emit(AdminRewardsSuccessState(adminRewardsDataModel: _currentData!));
      }
      emit(
        AdminRewardsStatusUpdateSuccessState(rewardsStatusUpdateModel: model),
      );
    } on NetworkTimeoutException {
      emit(RewardOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(RewardOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(RewardOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(RewardOperationErrorState('unknown_error'));
    }
  }

  Future<void> updateRewardPoints({
    required List<Map<String, dynamic>> updates,
  }) async {
    emit(RewardOperationLoadingState());
    try {
      final model = await adminRewardsUseCase.updateRewardPoints(
        updates: updates,
      );
      emit(
        AdminRewardsPointsUpdateSuccessState(rewardsPointsUpdateModel: model),
      );
    } on NetworkTimeoutException {
      emit(RewardOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(RewardOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(RewardOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(RewardOperationErrorState('unknown_error'));
    }
  }

  Future<void> adjustPoints({
    required String email,
    required int amount,
    required String reason,
  }) async {
    emit(RewardOperationLoadingState());
    try {
      final model = await adminRewardsUseCase.adjustPoints(
        email: email,
        amount: amount,
        reason: reason,
      );
      emit(AdminRewardsPointsAdjustSuccessState(pointsAdjustedModel: model));
    } on NetworkTimeoutException {
      emit(RewardOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(RewardOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(RewardOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(RewardOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(RewardOperationErrorState('unknown_error'));
    }
  }

  Future<void> createEarningRule({
    required String type,
    required String title,
    required int points,
    required String category,
    required bool isActive,
  }) async {
    emit(EarningRuleLoadingState());
    try {
      final model = await adminRewardsUseCase.createEarningRule(
        type: type,
        title: title,
        points: points,
        category: category,
        isActive: isActive,
      );
      emit(EarningRuleCreateSuccessState(earningRuleCreateModel: model));
    } on NetworkTimeoutException {
      emit(EarningRuleOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(EarningRuleOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(EarningRuleOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(EarningRuleOperationErrorState('unknown_error'));
    }
  }


  Future<void> deleteEarningRule({required String id}) async {
    // Don't emit loading state - use a specific state for this operation
    try {
      final model = await adminRewardsUseCase.deleteEarningRule(id: id);
      emit(EarningRuleDeletedSuccessState(earningRuleDeletedModel: model));
    } on NetworkTimeoutException {
      emit(EarningRuleOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(EarningRuleOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(EarningRuleOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(EarningRuleOperationErrorState('unknown_error'));
    }
  }

  Future<void> getEarningRules() async {
    emit(EarningRuleLoadingState());
    try {
      final model = await adminRewardsUseCase.getEarningRules();
      emit(EarningRuleGetSuccessState(earningRuleModel: model));
    } on NetworkTimeoutException {
      emit(EarningRuleErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(EarningRuleErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(EarningRuleErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(EarningRuleErrorState('not_found'));
    } on RequestCancelledException {
      emit(EarningRuleErrorState('request_cancelled'));
    } catch (e) {
      emit(EarningRuleErrorState('unknown_error'));
    }
  }

  Future<void> updateEarningRule({
    required String id,
    required int points,
  }) async {
    // Don't emit loading state - use a specific state for this operation
    try {
      final model = await adminRewardsUseCase.updateEarningRule(
        id: id,
        points: points,
      );
      emit(EarningRuleUpdatedSuccessState(earningRuleUpdatedModel: model));
    } on NetworkTimeoutException {
      emit(EarningRuleOperationErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(EarningRuleOperationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(EarningRuleOperationErrorState('not_found'));
    } on RequestCancelledException {
      emit(EarningRuleOperationErrorState('request_cancelled'));
    } catch (e) {
      emit(EarningRuleOperationErrorState('unknown_error'));
    }
  }
}

// --- States ---

sealed class AdminRewardsState {}

class AdminRewardsInitialState extends AdminRewardsState {}

class AdminRewardsLoadingState extends AdminRewardsState {}

class AdminRewardsSuccessState extends AdminRewardsState {
  final AdminRewardsDataModel adminRewardsDataModel;

  AdminRewardsSuccessState({required this.adminRewardsDataModel});
}

class AdminRewardsCreateSuccessState extends AdminRewardsState {
  final RewardCreateModel rewardCreateModel;

  AdminRewardsCreateSuccessState({required this.rewardCreateModel});
}

class AdminRewardsStatusUpdateSuccessState extends AdminRewardsState {
  final RewardsStatusUpdateModel rewardsStatusUpdateModel;

  AdminRewardsStatusUpdateSuccessState({
    required this.rewardsStatusUpdateModel,
  });
}

class AdminRewardsPointsUpdateSuccessState extends AdminRewardsState {
  final RewardsPointsUpdateModel rewardsPointsUpdateModel;

  AdminRewardsPointsUpdateSuccessState({
    required this.rewardsPointsUpdateModel,
  });
}

class AdminRewardsPointsAdjustSuccessState extends AdminRewardsState {
  final PointsAdjustedModel pointsAdjustedModel;

  AdminRewardsPointsAdjustSuccessState({required this.pointsAdjustedModel});
}

class AdminRewardsErrorState extends AdminRewardsState {
  final String error;

  AdminRewardsErrorState(this.error);
}

// ─── Reward Operation Specific States ───────────────────────────────────

class RewardOperationLoadingState extends AdminRewardsState {}

class RewardOperationErrorState extends AdminRewardsState {
  final String error;

  RewardOperationErrorState(this.error);
}

// ─── Earning Rule Specific States ───────────────────────────────────────
// These states are isolated to earning rule operations and don't affect
// other tabs' state management

class EarningRuleLoadingState extends AdminRewardsState {}

class EarningRuleErrorState extends AdminRewardsState {
  final String error;

  EarningRuleErrorState(this.error);
}

class EarningRuleOperationErrorState extends AdminRewardsState {
  final String error;

  EarningRuleOperationErrorState(this.error);
}

class EarningRuleCreateSuccessState extends AdminRewardsState {
  final EarningRuleCreateModel earningRuleCreateModel;

  EarningRuleCreateSuccessState({required this.earningRuleCreateModel});
}

class EarningRuleDeletedSuccessState extends AdminRewardsState {
  final EarningRuleDeletedModel earningRuleDeletedModel;

  EarningRuleDeletedSuccessState({required this.earningRuleDeletedModel});
}

class EarningRuleGetSuccessState extends AdminRewardsState {
  final EarningRuleModel earningRuleModel;

  EarningRuleGetSuccessState({required this.earningRuleModel});
}

class EarningRuleUpdatedSuccessState extends AdminRewardsState {
  final EarningRuleUpdatedModel earningRuleUpdatedModel;

  EarningRuleUpdatedSuccessState({required this.earningRuleUpdatedModel});
}