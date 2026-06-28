import 'dart:developer';

import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/errors/app_exceptions.dart';
import '../../domain/use_case/admin_requests_use_case.dart';

class AdminRequestsCubit extends Cubit<AdminRequestsState> {
  final AdminRequestsUseCase adminRequestsUseCase;
  AdminRequestsCubit({required this.adminRequestsUseCase}) : super(AdminRequestsInitialState());

  AdminRequestModel? _currentModel;
  String _currentStatus = 'pending';
  int _currentPage = 1;
  int _currentLimit = 10;
  bool _isLastPage = false;
  bool _isFetchingMore = false;

  bool get isLastPage => _isLastPage;
  bool get isFetchingMore => _isFetchingMore;
  AdminRequestModel? get currentModel => _currentModel;

  Future<void> getAdminRequests({
    required String status,
    required int page,
    required int limit,
  }) async {
    _currentStatus = status;
    _currentPage = page;
    _currentLimit = limit;
    _isLastPage = false;
    _isFetchingMore = false;
    emit(AdminRequestsLoadingState());
    try {
      final adminRequestModel = await adminRequestsUseCase.getAdminRequests(
        status: status,
        page: page,
        limit: limit,
      );
      if (adminRequestModel.success == true && adminRequestModel.data != null) {
        _currentModel = adminRequestModel;
        _updateLastPageFlag();
        emit(AdminRequestsSuccessState(adminRequestModel));
      } else {
        emit(AdminRequestsErrorState('failed_to_load_requests'));
      }
    } on NetworkTimeoutException {
      emit(AdminRequestsErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AdminRequestsErrorState(mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      log('ServerException: ${e.serverMessage}');
      emit(AdminRequestsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AdminRequestsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AdminRequestsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AdminRequestsErrorState('unknown_error'));
    } catch (e) {
      log('Unknown error: $e');
      emit(AdminRequestsErrorState('unknown_error'));
    }
  }

  Future<void> loadMoreRequests() async {
    if (_isFetchingMore || _isLastPage || _currentModel == null) return;

    final nextPage = _currentPage + 1;
    _isFetchingMore = true;
    emit(AdminRequestsLoadingMoreState(_currentModel!));

    try {
      final adminRequestModel = await adminRequestsUseCase.getAdminRequests(
        status: _currentStatus,
        page: nextPage,
        limit: _currentLimit,
      );

      if (adminRequestModel.success == true && adminRequestModel.data != null) {
        final List<Requests> newRequests =
            adminRequestModel.data?.requests ?? <Requests>[];

        final List<Requests> mergedRequests = <Requests>[
          ...(_currentModel?.data?.requests ?? <Requests>[]),
          ...newRequests,
        ];

        _currentModel?.data?.requests = mergedRequests;
        _currentModel?.data?.page = adminRequestModel.data?.page;
        _currentModel?.data?.total = adminRequestModel.data?.total;
        _currentPage = nextPage;

        if (newRequests.length < _currentLimit) {
          _isLastPage = true;
        }
        _updateLastPageFlag();

        emit(AdminRequestsSuccessState(_currentModel!));
      } else {
        _isLastPage = true;
        emit(AdminRequestsSuccessState(_currentModel!));
      }
    } catch (e) {
      emit(AdminRequestsSuccessState(_currentModel!));
    } finally {
      _isFetchingMore = false;
    }
  }

  Future<void> markRequestAsFulfilled({required String requestId}) async {
    if (_currentModel == null) return;

    emit(AdminRequestActionInProgressState(
      requestId: requestId,
      action: AdminRequestAction.markAsFulfilled,
      adminRequestModel: _currentModel!,
    ));

    try {
      final result = await adminRequestsUseCase.markRequestAsFulfilled(
        requestId: requestId,
      );

      if (result.success == true) {
        _removeRequestById(requestId, markedFulfilled: true);
        emit(AdminRequestActionSuccessState(
          requestId: requestId,
          action: AdminRequestAction.markAsFulfilled,
          adminRequestModel: _currentModel!,
          message: result.message ?? 'request_marked_as_fulfilled',
        ));
      } else {
        emit(AdminRequestActionErrorState(
          requestId: requestId,
          action: AdminRequestAction.markAsFulfilled,
          adminRequestModel: _currentModel!,
          errorMessage: result.message ?? 'failed_to_mark_as_fulfilled',
        ));
      }
    } on NetworkTimeoutException {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, 'network_timeout');
    } on UnauthorizedException catch (e) {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, mapServerErrorToKey(e.message));
    } on ServerException catch (e) {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, mapServerErrorToKey(e.serverMessage));
    } on NotFoundException {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, 'not_found');
    } on RequestCancelledException {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, 'request_cancelled');
    } on UnknownNetworkException {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, 'unknown_error');
    } catch (e) {
      _emitActionError(requestId, AdminRequestAction.markAsFulfilled, 'unknown_error');
    }
  }

  Future<void> cancelRequest({required String requestId}) async {
    if (_currentModel == null) return;

    emit(AdminRequestActionInProgressState(
      requestId: requestId,
      action: AdminRequestAction.cancel,
      adminRequestModel: _currentModel!,
    ));

    try {
      final result = await adminRequestsUseCase.cancelRequest(requestId: requestId);

      if (result.success == true) {
        _removeRequestById(requestId);
        emit(AdminRequestActionSuccessState(
          requestId: requestId,
          action: AdminRequestAction.cancel,
          adminRequestModel: _currentModel!,
          message: result.message ?? 'request_cancelled_successfully',
        ));
      } else {
        emit(AdminRequestActionErrorState(
          requestId: requestId,
          action: AdminRequestAction.cancel,
          adminRequestModel: _currentModel!,
          errorMessage: result.message ?? 'failed_to_cancel_request',
        ));
      }
    } on NetworkTimeoutException {
      _emitActionError(requestId, AdminRequestAction.cancel, 'network_timeout');
    } on UnauthorizedException catch (e) {
      _emitActionError(requestId, AdminRequestAction.cancel, mapServerErrorToKey(e.message));
    } on ServerException catch (e) {
      _emitActionError(requestId, AdminRequestAction.cancel, mapServerErrorToKey(e.serverMessage));
    } on NotFoundException {
      _emitActionError(requestId, AdminRequestAction.cancel, 'not_found');
    } on RequestCancelledException {
      _emitActionError(requestId, AdminRequestAction.cancel, 'request_cancelled');
    } on UnknownNetworkException {
      _emitActionError(requestId, AdminRequestAction.cancel, 'unknown_error');
    } catch (e) {
      _emitActionError(requestId, AdminRequestAction.cancel, 'unknown_error');
    }
  }


  Future<void> broadcastRequest({required String requestId}) async {
   // if (_currentModel == null) return;

    emit(AdminRequestActionInProgressState(
      requestId: requestId,
      action: AdminRequestAction.broadcast,
      adminRequestModel: _currentModel!,
    ));

    try {
      final result = await adminRequestsUseCase.broadcastRequest(requestId: requestId);

      if (result.success == true) {
        emit(AdminRequestActionSuccessState(
          requestId: requestId,
          action: AdminRequestAction.broadcast,
          adminRequestModel: _currentModel!,
          message: result.message ?? 'request_broadcasted_successfully',
        ));
      } else {
        emit(AdminRequestActionErrorState(
          requestId: requestId,
          action: AdminRequestAction.broadcast,
          adminRequestModel: _currentModel!,
          errorMessage: result.message ?? 'failed_to_broadcast_request',
        ));
      }
    } on NetworkTimeoutException {
      _emitActionError(requestId, AdminRequestAction.broadcast, 'network_timeout');
    } on UnauthorizedException catch (e) {
      _emitActionError(requestId, AdminRequestAction.broadcast, mapServerErrorToKey(e.message));
    } on ServerException catch (e) {
      _emitActionError(requestId, AdminRequestAction.broadcast, mapServerErrorToKey(e.serverMessage));
    } on NotFoundException {
      _emitActionError(requestId, AdminRequestAction.broadcast, 'not_found');
    } on RequestCancelledException {
      _emitActionError(requestId, AdminRequestAction.broadcast, 'request_cancelled');
    } on UnknownNetworkException {
      _emitActionError(requestId, AdminRequestAction.broadcast, 'unknown_error');
    } catch (e) {
      _emitActionError(requestId, AdminRequestAction.broadcast, 'unknown_error');
    }
  }

  void _emitActionError(String requestId, AdminRequestAction action, String message) {
    if (_currentModel == null) return;
    emit(AdminRequestActionErrorState(
      requestId: requestId,
      action: action,
      adminRequestModel: _currentModel!,
      errorMessage: message,
    ));
  }

  void _removeRequestById(String requestId, {bool markedFulfilled = false}) {
    final requests = _currentModel?.data?.requests;
    if (requests == null) return;

    requests.removeWhere((r) => r.id == requestId);

    final currentTotal = _currentModel?.data?.total;
    if (currentTotal != null && currentTotal > 0) {
      _currentModel?.data?.total = currentTotal - 1;
    }

    if (markedFulfilled) {
      final stats = _currentModel?.data?.stats;
      if (stats?.byStatus != null) {
        stats!.byStatus!.completed = (stats.byStatus!.completed ?? 0) + 1;
      }
    }

    _updateLastPageFlag();
  }

  void _updateLastPageFlag() {
    final total = _currentModel?.data?.total;
    final loadedCount = _currentModel?.data?.requests?.length ?? 0;
    if (total != null && loadedCount >= total) {
      _isLastPage = true;
    }
  }
}

enum AdminRequestAction { markAsFulfilled, cancel, broadcast }

sealed class AdminRequestsState {}

class AdminRequestsInitialState extends AdminRequestsState {}

class AdminRequestsLoadingState extends AdminRequestsState {}

class AdminRequestsLoadingMoreState extends AdminRequestsState {
  final AdminRequestModel adminRequestModel;
  AdminRequestsLoadingMoreState(this.adminRequestModel);
}

class AdminRequestsSuccessState extends AdminRequestsState {
  final AdminRequestModel adminRequestModel;
  AdminRequestsSuccessState(this.adminRequestModel);
}

class AdminRequestsErrorState extends AdminRequestsState {
  final String errorMessage;
  AdminRequestsErrorState(this.errorMessage);
}

class AdminRequestActionInProgressState extends AdminRequestsState {
  final String requestId;
  final AdminRequestAction action;
  final AdminRequestModel adminRequestModel;

  AdminRequestActionInProgressState({
    required this.requestId,
    required this.action,
    required this.adminRequestModel,
  });
}

class AdminRequestActionSuccessState extends AdminRequestsState {
  final String requestId;
  final AdminRequestAction action;
  final AdminRequestModel adminRequestModel;
  final String message;

  AdminRequestActionSuccessState({
    required this.requestId,
    required this.action,
    required this.adminRequestModel,
    required this.message,
  });
}

class AdminRequestActionErrorState extends AdminRequestsState {
  final String requestId;
  final AdminRequestAction action;
  final AdminRequestModel adminRequestModel;
  final String errorMessage;

  AdminRequestActionErrorState({
    required this.requestId,
    required this.action,
    required this.adminRequestModel,
    required this.errorMessage,
  });
}