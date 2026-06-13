import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/domain/use_case/analytics/analytics_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../data/model/analytics/analytics_model.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsUseCase analyticsUseCase;

  AnalyticsCubit({required this.analyticsUseCase})
      : super(AnalyticsInitialState());

  Future<void> fetchAnalytics() async {
    emit(AnalyticsLoadingState());
    try {
      final analyticsModel = await analyticsUseCase.getAnalytics();
      if (analyticsModel.success == true && analyticsModel.data != null) {
        emit(AnalyticsSuccessState(analyticsModel));
      } else {
        emit(AnalyticsErrorState('failed_to_load_analytics'));
      }
    } on NetworkTimeoutException {
      emit(AnalyticsErrorState('network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AnalyticsErrorState(e.message ?? 'unauthorized'));
    } on ServerException catch (e) {
      emit(AnalyticsErrorState(e.serverMessage ?? 'server_error'));
    } on NotFoundException {
      emit(AnalyticsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AnalyticsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AnalyticsErrorState('unknown_error'));
    } catch (e) {
      emit(AnalyticsErrorState('unknown_error'));
    }
  }
}

sealed class AnalyticsState {}
class AnalyticsInitialState extends AnalyticsState {}
class AnalyticsLoadingState extends AnalyticsState {}
class AnalyticsSuccessState extends AnalyticsState {
  final AnalyticsModel analyticsModel;
  AnalyticsSuccessState(this.analyticsModel);
}
class AnalyticsErrorState extends AnalyticsState {
  final String errorMessage;
  AnalyticsErrorState(this.errorMessage);
}
