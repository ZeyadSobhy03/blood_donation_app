import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/analytics_overview_model.dart';
import '../../domain/use_case/analytics_overview_use_case.dart';

class AnalyticsOverviewCubit extends Cubit<AnalyticsOverviewState> {
  final AnalyticsOverviewUseCase analyticsOverviewUseCase;

  AnalyticsOverviewCubit({required this.analyticsOverviewUseCase})
      : super(AnalyticsOverviewInitialState());

  Future<void> getAnalyticsOverview() async {
    emit(AnalyticsOverviewLoadingState());
    try {
      final overview = await analyticsOverviewUseCase.getAnalyticsOverview();
      if (overview.success == true && overview.data != null) {
        emit(AnalyticsOverviewSuccessState(overview));
      } else {
        emit(AnalyticsOverviewErrorState('failed_to_load_analytics_overview'));
      }
    } on NetworkTimeoutException {
      emit(AnalyticsOverviewErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AnalyticsOverviewErrorState(e.message ?? 'unauthorized'));
    } on ServerException catch (e) {
      emit(AnalyticsOverviewErrorState(e.serverMessage ?? 'server_error'));
    } on NotFoundException {
      emit(AnalyticsOverviewErrorState('not_found'));
    } on RequestCancelledException {
      emit(AnalyticsOverviewErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AnalyticsOverviewErrorState('unknown_error'));
    } catch (e) {
      emit(AnalyticsOverviewErrorState('unknown_error'));
    }
  }
}

sealed class AnalyticsOverviewState {}
class AnalyticsOverviewInitialState extends AnalyticsOverviewState {}
class AnalyticsOverviewLoadingState extends AnalyticsOverviewState {}
class AnalyticsOverviewSuccessState extends AnalyticsOverviewState {
  final AnalyticsOverviewModel analyticsOverviewModel;
  AnalyticsOverviewSuccessState(this.analyticsOverviewModel);
}
class AnalyticsOverviewErrorState extends AnalyticsOverviewState {
  final String errorMessage;
  AnalyticsOverviewErrorState(this.errorMessage);
}