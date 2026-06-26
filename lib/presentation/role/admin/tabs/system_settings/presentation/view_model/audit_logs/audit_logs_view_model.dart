import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/audit_logs/audit_logs_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/audit_logs/audit_logs_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';

class AuditLogsCubit extends Cubit<AuditLogsState> {
  final AuditLogsUseCase auditLogsUseCase;

  int _currentPage = 1;
  final int _limit = 20;
  List<Logs> _allLogs = [];
  String? _targetType;
  String? _action;

  AuditLogsCubit({
    required this.auditLogsUseCase,
  }) : super(AuditLogsInitialState());

  String? get currentTargetType => _targetType;
  String? get currentAction => _action;

  Future<void> getAuditLogs({
    bool isRefresh = false,
    bool isLoadMore = false,
    String? targetType,
    String? action,
  }) async {
    if (isRefresh) {
      _currentPage = 1;
      _allLogs.clear();
      _targetType = targetType;
      _action = action;
      emit(AuditLogsLoadingState());
    } else if (isLoadMore) {
      if (state is AuditLogsLoadedState) {
        final current = state as AuditLogsLoadedState;
        emit(AuditLogsLoadedState(
          logs: current.logs,
          hasReachedMax: current.hasReachedMax,
          isLoadingMore: true,
        ));
      }
    }

    try {
      final response = await auditLogsUseCase.getAuditLogs(
        page: _currentPage,
        limit: _limit,
        targetType: _targetType,
        action: _action,
      );

      final newLogs = response.data?.logs ?? [];
      final pagination = response.data?.pagination;

      if (isRefresh) {
        _allLogs = newLogs;
      } else {
        _allLogs.addAll(newLogs);
      }

      final bool hasReachedMax = pagination == null ||
          (pagination.page ?? 1) >= (pagination.totalPages ?? 1);

      if (!hasReachedMax) {
        _currentPage++;
      }

      emit(AuditLogsLoadedState(
        logs: List.from(_allLogs),
        hasReachedMax: hasReachedMax,
        isLoadingMore: false,
      ));
    } on NetworkTimeoutException {
      emit(AuditLogsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AuditLogsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(AuditLogsErrorState('unauthorized'));
    } on NotFoundException {
      emit(AuditLogsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AuditLogsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AuditLogsErrorState('unknown_error'));
    } catch (e) {
      emit(AuditLogsErrorState('unknown_error'));
    }
  }
}

sealed class AuditLogsState {}

class AuditLogsInitialState extends AuditLogsState {}

class AuditLogsLoadingState extends AuditLogsState {}

class AuditLogsLoadedState extends AuditLogsState {
  final List<Logs> logs;
  final bool hasReachedMax;
  final bool isLoadingMore;

  AuditLogsLoadedState({
    required this.logs,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });
}

class AuditLogsErrorState extends AuditLogsState {
  final String errorMessage;
  AuditLogsErrorState(this.errorMessage);
}