
import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/activities/activities_model.dart';
import '../../../domain/use_case/activities/activities_use_case.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivitiesUseCase activitiesUseCase;

  ActivitiesCubit({required this.activitiesUseCase})
      : super(ActivitiesInitialState());

  Future<void> fetchActivities({int page = 1, int limit = 10}) async {
    emit(ActivitiesLoadingState());
    try {
      final activitiesModel = await activitiesUseCase.getActivities(
        page: page,
        limit: limit,
      );
      emit(ActivitiesSuccessState(activitiesModel));
    } on NetworkTimeoutException {
      emit(ActivitiesErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(ActivitiesErrorState(e.serverMessage ?? 'server_error'));
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
    }
  }
}

sealed class ActivitiesState {}

class ActivitiesInitialState extends ActivitiesState {}

class ActivitiesLoadingState extends ActivitiesState {}

class ActivitiesSuccessState extends ActivitiesState {
  final ActivitiesModel activitiesModel;
  ActivitiesSuccessState(this.activitiesModel);
}

class ActivitiesErrorState extends ActivitiesState {
  final String message;
  ActivitiesErrorState(this.message);
}