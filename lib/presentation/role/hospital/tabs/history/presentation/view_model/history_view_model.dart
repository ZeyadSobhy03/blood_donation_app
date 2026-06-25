import 'dart:developer';

import 'package:blood_donation_app/core/resources/models/summary_model.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/domain/use_cases/history_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryUseCase historyUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  AppLocalizations? _loc;

  HistoryCubit({
    required this.historyUseCase,
    required this.hospitalLocalDataSource,
  }) : super(HistoryInitialState());

  void setAppLoc(AppLocalizations loc) => _loc = loc;


  int _currentPage = 1;
  static const int _pageSize = 10;

  final List<HistoryRequestModel> _allRequests = [];
  HistoryPagination? _pagination;
  SummaryModel? _summaryModel;


  Future<void> fetchHistory({
    String? status,
    required AppLocalizations loc,
  }) async {
    try {
      emit(HistoryLoadingState());

      _currentPage = 1;
      _allRequests.clear();

      final token = await _getToken();
      if (isClosed) return;

      final result = await historyUseCase(
        token: token,
        status: status,
        page: _currentPage,
        limit: _pageSize,
      );
      if (isClosed) return;

      _handleResult(result, loc);
    } catch (e) {
      log('HistoryCubit.fetchHistory error: $e');
      if (!isClosed) {
        emit(HistoryErrorState(message: _parseError(e.toString())));
      }
    }
  }


  Future<void> loadMore({
    String? status,
    required AppLocalizations loc,
  }) async {
    if (_pagination?.hasNextPage != true) return;
    if (state is HistoryPaginatingState) return;

    try {
      emit(HistoryPaginatingState(
        currentRequests: List.from(_allRequests),
        summaryModel: _summaryModel,
      ));

      _currentPage++;
      final token = await _getToken();
      if (isClosed) return;

      final result = await historyUseCase(
        token: token,
        status: status,
        page: _currentPage,
        limit: _pageSize,
      );
      if (isClosed) return;

      _handleResult(result, loc);
    } catch (e) {
      log('HistoryCubit.loadMore error: $e');
      _currentPage--;
      if (!isClosed) {
        emit(HistorySuccessState(
          requests: List.from(_allRequests),
          summaryModel: _summaryModel,
          pagination: _pagination,
        ));
      }
    }
  }


  void _handleResult(HistoryModel result, AppLocalizations loc) {
    if (_currentPage == 1 && result.data?.statistics != null) {
      _summaryModel = result.data!.toSummaryModel();
    }

    _pagination = result.data?.pagination;

    final newRequests = result.data?.requests ?? [];
    _allRequests.addAll(newRequests);

    if (_allRequests.isEmpty) {
      emit(HistoryEmptyState(summaryModel: _summaryModel));
    } else {
      emit(HistorySuccessState(
        requests: List.from(_allRequests),
        summaryModel: _summaryModel,
        pagination: _pagination,
      ));
    }
  }

  Future<String> _getToken() async {
    final token = await hospitalLocalDataSource.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('UNAUTHORIZED');
    return token;
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return _loc?.connectionTimedOut ?? 'Connection timed out. Please try again.';
    if (e.contains('no_internet') || e.contains('connectionerror')) {
      return _loc?.noInternetConnection ?? 'No internet connection.';
    }
    if (e.contains('unauthorized')) {
      return _loc?.sessionExpired ?? 'Session expired. Please log in again.';
    }
    if (e.contains('access_denied')) return _loc?.accessDenied ?? 'Access denied.';
    if (e.contains('invalid_status_filter')) return _loc?.invalidStatusFilter ?? 'Invalid status filter.';
    return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }

  void reset() => emit(HistoryInitialState());
}



sealed class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<HistoryRequestModel> requests;
  final SummaryModel? summaryModel;
  final HistoryPagination? pagination;

  HistorySuccessState({
    required this.requests,
    this.summaryModel,
    this.pagination,
  });

  bool get hasMore => pagination?.hasNextPage ?? false;
}

class HistoryPaginatingState extends HistoryState {
  final List<HistoryRequestModel> currentRequests;
  final SummaryModel? summaryModel;

  HistoryPaginatingState({
    required this.currentRequests,
    this.summaryModel,
  });
}

class HistoryEmptyState extends HistoryState {
  final SummaryModel? summaryModel;

  HistoryEmptyState({this.summaryModel});
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState({required this.message});
}