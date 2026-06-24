import 'dart:developer';

import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_contact/support_contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../domain/use_case/support_contact/support_contact_use_case.dart';

class SupportContactCubit extends Cubit<SupportContactState> {
  final SupportContactUseCase supportContactUseCase;

  SupportContactCubit({required this.supportContactUseCase})
      : super(SupportContactInitialState());

  Future<void> sendSupportRequest({
    required String subject,
    required String category,
    required String message,
  }) async {
    emit(SupportContactLoadingState());
    try {
      final supportContactModel = await supportContactUseCase.supportRequest(
        subject: subject,
        category: category,
        message: message,
      );
      emit(SupportContactSuccessState(supportContactModel));
    } on NetworkTimeoutException {
      emit(SupportContactErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      log('Error sending support request: ${e.serverMessage}');
      emit(SupportContactErrorState(
          error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(SupportContactErrorState(error: 'unauthorized'));
    } on NotFoundException {
      emit(SupportContactErrorState(error: 'not_found'));
    } on RequestCancelledException {
      emit(SupportContactErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(SupportContactErrorState(error: 'unknown_error'));
    } catch (e) {
      log('Unknown error while sending support request: $e');
      emit(SupportContactErrorState(error: 'unknown_error'));
    }
  }

  Future<void> retrySendSupportRequest({
    required String subject,
    required String category,
    required String message,
  }) async {
    if (state is SupportContactErrorState) {
      await sendSupportRequest(
        subject: subject,
        category: category,
        message: message,
      );
    }
  }

  void reset() {
    emit(SupportContactInitialState());
  }
}

sealed class SupportContactState {}

class SupportContactInitialState extends SupportContactState {}

class SupportContactLoadingState extends SupportContactState {}

class SupportContactSuccessState extends SupportContactState {
  final SupportContactModel supportContactModel;

  SupportContactSuccessState(this.supportContactModel);
}

class SupportContactErrorState extends SupportContactState {
  final String error;

  SupportContactErrorState({required this.error});
}