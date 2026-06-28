import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/fcm/fcm_model.dart';
import '../../../domain/use_cases/fcm/fcm_use_case.dart';

class FcmCubit extends Cubit<FcmState> {
  final FcmUseCase fcmUseCase;

  FcmCubit({required this.fcmUseCase}) : super(FcmInitialState());

  Future<void> saveFcmToken({
    required String token,
    required String accessToken,
  }) async {
    emit(FcmLoadingState());
    try {
      final fcmModel = await fcmUseCase.saveFcmToken(
        token: token,
        accessToken: accessToken,
      );
      emit(FcmSuccessState(fcmModel));
    } catch (e) {
      emit(FcmErrorState(_parseError(e.toString())));
    }
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return 'Connection timed out';
    if (e.contains('unauthorized')) return 'Session expired';
    if (e.contains('unknown_error')) return 'Something went wrong';
    return 'Something went wrong';
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
