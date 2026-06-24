import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_cancel_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/requests/requests_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';

class CancelRequestCubit extends Cubit<CancelRequestState> {
  final RequestsUseCase requestsUseCase;

  CancelRequestCubit({required this.requestsUseCase})
      : super(CancelRequestInitialState());

  Future<void> cancelRequest({required String requestId}) async {
    emit(CancelRequestLoadingState());
    try {
      final cancelRequestModel = await requestsUseCase.cancelRequest(
        requestId: requestId,
      );
      emit(CancelRequestSuccessState(cancelRequestModel));
    } on NetworkTimeoutException {
      emit(CancelRequestErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(CancelRequestErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(CancelRequestErrorState('unauthorized'));
    } on NotFoundException {
      emit(CancelRequestErrorState('not_found'));
    } on RequestCancelledException {
      emit(CancelRequestAlreadyCancelledState());
    } on UnknownNetworkException {
      emit(CancelRequestErrorState('unknown_error'));
    } catch (e) {
      emit(CancelRequestErrorState('unknown_error'));
    }
  }
}

sealed class CancelRequestState {}
class CancelRequestInitialState extends CancelRequestState {}
class CancelRequestLoadingState extends CancelRequestState {}
class CancelRequestSuccessState extends CancelRequestState {
  final RequestCancelModel cancelRequestModel;
  CancelRequestSuccessState(this.cancelRequestModel);
}
class CancelRequestAlreadyCancelledState extends CancelRequestState {}
class CancelRequestErrorState extends CancelRequestState {
  final String message;
  CancelRequestErrorState(this.message);
}