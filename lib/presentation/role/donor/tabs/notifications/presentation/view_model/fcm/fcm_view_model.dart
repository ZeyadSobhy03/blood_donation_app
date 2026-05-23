
import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/fcm/fcm_model.dart';
import '../../../domain/use_cases/fcm/fcm_use_case.dart';

class FcmCubit extends Cubit<FcmState> {
  final FcmUseCase fcmUseCase;

  FcmCubit({required this.fcmUseCase}) : super(FcmInitialState());

  Future<void> saveFcmToken({required String token}) async {
    emit(FcmLoadingState());
    try {
      final fcmModel = await fcmUseCase.saveFcmToken(token);
      emit(FcmSuccessState(fcmModel));
    } on NetworkTimeoutException {
      emit(FcmErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(FcmErrorState(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(FcmErrorState('unauthorized'));
    } on NotFoundException {

      emit(FcmErrorState('not_found'));
    } on RequestCancelledException {
      emit(FcmErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(FcmErrorState('unknown_error'));
    } catch (e) {
      emit(FcmErrorState('unknown_error'));
    }
  }
}

sealed class FcmState {}

class FcmInitialState extends FcmState {}

class FcmLoadingState extends FcmState {}

class FcmSuccessState extends FcmState {
  final FcmModel fcmModel;
  FcmSuccessState(this.fcmModel);
}

class FcmErrorState extends FcmState {
  final String message;
  FcmErrorState(this.message);
}