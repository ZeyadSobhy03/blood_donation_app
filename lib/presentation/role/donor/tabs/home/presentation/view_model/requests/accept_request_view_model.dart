import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_accept_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/requests/requests_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';

class AcceptRequestCubit extends Cubit<AcceptRequestState> {
  final RequestsUseCase requestsUseCase;

  AcceptRequestCubit({required this.requestsUseCase})
      : super(AcceptRequestInitialState());

  Future<void> acceptRequest({required String requestId}) async {
    emit(AcceptRequestLoadingState());
    try {
      final result = await requestsUseCase.acceptRequest(requestId: requestId);
      emit(AcceptRequestSuccessState(result));
    } on NetworkTimeoutException {
      emit(AcceptRequestErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AcceptRequestErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(AcceptRequestErrorState('unauthorized'));
    } on NotFoundException {
      emit(AcceptRequestErrorState('not_found'));
    } on RequestCancelledException {
      emit(AcceptRequestErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AcceptRequestErrorState('unknown_error'));
    } catch (e) {
      emit(AcceptRequestErrorState('unknown_error'));
    }
  }
}

sealed class AcceptRequestState {}
class AcceptRequestInitialState extends AcceptRequestState {}
class AcceptRequestLoadingState extends AcceptRequestState {}
class AcceptRequestSuccessState extends AcceptRequestState {
  final RequestAcceptModel requestAcceptModel;
  AcceptRequestSuccessState(this.requestAcceptModel);
}
class AcceptRequestErrorState extends AcceptRequestState {
  final String message;
  AcceptRequestErrorState(this.message);
}