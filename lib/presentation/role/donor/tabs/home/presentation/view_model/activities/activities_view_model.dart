import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../data/model/activities/activities_model.dart';
import '../../../domain/use_case/activities/activities_use_case.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivitiesUseCase activitiesUseCase;

  ActivitiesCubit({required this.activitiesUseCase})
      : super(ActivitiesInitialState());

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isFetching = false;
  final List<Activities> _allActivities = [];

  Future<void> fetchActivities({bool isRefresh = false}) async {
    if (_isFetching) return;

    if (isRefresh) {
      _currentPage = 1;
      _hasNextPage = true;
      _allActivities.clear();
    }

    if (!_hasNextPage) return;

    _isFetching = true;

    if (_currentPage == 1) {
      emit(ActivitiesLoadingState());
    }

    try {
      final activitiesModel = await activitiesUseCase.getActivities(
        page: _currentPage,
        limit: 10,
      );

      final newActivities = activitiesModel.data?.activities ?? [];
      _hasNextPage = activitiesModel.data?.pagination?.hasNextPage ?? false;

      _allActivities.addAll(newActivities);

      emit(ActivitiesSuccessState(
        activities: List.from(_allActivities),
        hasNextPage: _hasNextPage,
      ));

      if (_hasNextPage) {
        _currentPage++;
      }
    } on NetworkTimeoutException {
      emit(ActivitiesErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(ActivitiesErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(ActivitiesErrorState('unauthorized'));
    } on NotFoundException {
      emit(ActivitiesErrorState('not_found'));
    } on RequestCancelledException {
      emit(ActivitiesErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(ActivitiesErrorState('unknown_error'));
    } catch (e) {
      emit(ActivitiesErrorState('unknown_error'));
    } finally {
      _isFetching = false;
    }
  }
}

sealed class ActivitiesState {}

class ActivitiesInitialState extends ActivitiesState {}

class ActivitiesLoadingState extends ActivitiesState {}

class ActivitiesSuccessState extends ActivitiesState {
  final List<Activities> activities;
  final bool hasNextPage;
  ActivitiesSuccessState({required this.activities, required this.hasNextPage});
}

class ActivitiesErrorState extends ActivitiesState {
  final String message;
  ActivitiesErrorState(this.message);
}
