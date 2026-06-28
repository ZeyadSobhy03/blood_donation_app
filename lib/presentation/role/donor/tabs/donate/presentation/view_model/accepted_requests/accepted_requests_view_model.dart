import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../data/model/accepted_requests/accepted_requests_model.dart';
import '../../../domain/use_case/accepted_requests/accepted_requests_use_case.dart';


class AcceptedRequestsCubit extends Cubit<AcceptedRequestsState> {
  final AcceptedRequestsUseCase acceptedRequestsUseCase;

  AcceptedRequestsCubit({required this.acceptedRequestsUseCase})
      : super(AcceptedRequestsInitialState());

  AcceptedRequestsModel? _currentModel;
  int _currentPage = 1;
  int _currentLimit = 10;
  bool _isLastPage = false;
  bool _isFetchingMore = false;

  bool get isLastPage => _isLastPage;
  bool get isFetchingMore => _isFetchingMore;
  AcceptedRequestsModel? get currentModel => _currentModel;

  Future<void> getAcceptedRequests({
    required int page,
    required int limit,
  }) async {
    _currentPage = page;
    _currentLimit = limit;
    _isLastPage = false;
    _isFetchingMore = false;
    emit(AcceptedRequestsLoadingState());

    try {
      final model = await acceptedRequestsUseCase.getAcceptedRequests(
        page: page,
        limit: limit,
      );

      if (model.success == true && model.data != null) {
        _currentModel = model;
        _updateLastPageFlag();
        emit(AcceptedRequestsSuccessState(_currentModel!));
      } else {
        emit(AcceptedRequestsErrorState('failed_to_load_requests'));
      }
    } on NetworkTimeoutException {
      emit(AcceptedRequestsErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AcceptedRequestsErrorState(e.message ?? 'unauthorized'));
    } on ServerException catch (e) {
      log('Server error during getAcceptedRequests: ${e.serverMessage}');
      emit(AcceptedRequestsErrorState(mapServerErrorToKey(e.serverMessage)));
    } catch (e) {
      log('Unknown error during getAcceptedRequests: $e');
      emit(AcceptedRequestsErrorState('unknown_error'));
    }
  }

  Future<void> loadMoreRequests() async {
    if (_isFetchingMore || _isLastPage || _currentModel == null) return;

    final nextPage = _currentPage + 1;
    _isFetchingMore = true;
    emit(AcceptedRequestsLoadingMoreState(_currentModel!));

    try {
      final model = await acceptedRequestsUseCase.getAcceptedRequests(
        page: nextPage,
        limit: _currentLimit,
      );

      if (model.success == true && model.data != null) {
        final List<Requests> newRequests = model.data?.requests ?? [];

        final List<Requests> mergedRequests = [
          ...(_currentModel?.data?.requests ?? []),
          ...newRequests,
        ];

        _currentModel?.data?.requests = mergedRequests;
        _currentModel?.data?.pagination = model.data?.pagination;
        _currentPage = nextPage;

        _updateLastPageFlag();

        emit(AcceptedRequestsSuccessState(_currentModel!));
      } else {
        _isLastPage = true;
        emit(AcceptedRequestsSuccessState(_currentModel!));
      }
    } on NetworkTimeoutException {
      _isFetchingMore = false;
      if (_currentModel != null) {
        emit(AcceptedRequestsErrorState('network_timeout'));
      }
    } on UnauthorizedException catch (e) {
      _isFetchingMore = false;
      if (_currentModel != null) {
        emit(AcceptedRequestsErrorState(e.message ?? 'unauthorized'));
      }
    } on ServerException catch (e) {
      log('Server error during loadMoreRequests: ${e.serverMessage}');
      _isFetchingMore = false;
      if (_currentModel != null) {
        emit(AcceptedRequestsErrorState(mapServerErrorToKey(e.serverMessage)));
      }
    } catch (e) {
      log('Unknown error during loadMoreRequests: $e');
      _isFetchingMore = false;
      if (_currentModel != null) {
        emit(AcceptedRequestsSuccessState(_currentModel!));
      } else {
        emit(AcceptedRequestsErrorState('unknown_error'));
      }
    }
  }

  void _updateLastPageFlag() {
    final hasNextPage = _currentModel?.data?.pagination?.hasNextPage ?? false;
    if (!hasNextPage) {
      _isLastPage = true;
    }
  }
}

sealed class AcceptedRequestsState {}

class AcceptedRequestsInitialState extends AcceptedRequestsState {}

class AcceptedRequestsLoadingState extends AcceptedRequestsState {}

class AcceptedRequestsLoadingMoreState extends AcceptedRequestsState {
  final AcceptedRequestsModel model;
  AcceptedRequestsLoadingMoreState(this.model);
}

class AcceptedRequestsSuccessState extends AcceptedRequestsState {
  final AcceptedRequestsModel model;
  AcceptedRequestsSuccessState(this.model);
}

class AcceptedRequestsErrorState extends AcceptedRequestsState {
  final String errorMessage;
  AcceptedRequestsErrorState(this.errorMessage);
}