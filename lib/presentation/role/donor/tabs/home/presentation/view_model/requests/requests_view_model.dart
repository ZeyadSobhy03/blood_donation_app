import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../data/model/requests/requests_model.dart';
import '../../../domain/use_case/requests/requests_use_case.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsUseCase requestsUseCase;

  RequestsCubit({required this.requestsUseCase}) : super(RequestsInitialState());

  Future<void> fetchRequests({
    required int limit,
    required int  page,

  }) async {
    emit(RequestsLoadingState());
    try {
      final requestsModel = await requestsUseCase.getRequests(
        limit: limit,
        page: page,
      );
      emit(RequestsSuccessState(requestsModel));
    } on NetworkTimeoutException {
      emit(RequestsErrorState('network_timeout'));
    } on ServerException catch (e) {

      emit(RequestsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RequestsErrorState('unauthorized'));
    } on NotFoundException {
      emit(RequestsErrorState('not_found'));
    } on RequestCancelledException {
      emit(RequestsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RequestsErrorState('unknown_error'));
    } catch (e) {
      emit(RequestsErrorState('unknown_error'));
    }
  }

  Future<Requests?> fetchRequestById({
    required String requestId,
  }) async {
    try {
      return await requestsUseCase.getRequestById(requestId: requestId);
    } catch (e) {
      return null;
    }
  }
}

sealed class RequestsState {}
class RequestsInitialState extends RequestsState {}
class RequestsLoadingState extends RequestsState {}
class RequestsSuccessState extends RequestsState {
  final RequestsModel requestsModel;
  RequestsSuccessState(this.requestsModel);
}
class RequestsErrorState extends RequestsState {
  final String message;
  RequestsErrorState(this.message);
}