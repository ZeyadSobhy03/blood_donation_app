
import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/time_slots/time_slots_model.dart';
import '../../../domain/use_cases/time_slots/time_slots_use_case.dart';

class TimeSlotsCubit extends Cubit<TimeSlotsState> {
  final TimeSlotsUseCase timeSlotsUseCase;

  TimeSlotsCubit({required this.timeSlotsUseCase})
    : super(TimeSlotsInitialState());

  Future<void> fetchTimeSlots({
    required String hospitalId,
    required String date,
  }) async {
    try {
      emit(TimeSlotsLoadingState());
      final timeSlots = await timeSlotsUseCase.getTimeSlots(
        date: date,
        hospitalId: hospitalId,
      );

      if (timeSlots.success == true && timeSlots.data != null) {
        emit(TimeSlotsSuccessState(timeSlots));
      } else {
        emit(TimeSlotsErrorState('server_error'));
      }
    } on NetworkTimeoutException {
      emit(TimeSlotsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(TimeSlotsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(TimeSlotsErrorState('unauthorized'));
    } on NotFoundException {
      emit(TimeSlotsErrorState('not_found'));
    } on RequestCancelledException {
      emit(TimeSlotsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(TimeSlotsErrorState('unknown_error'));
    } catch (e) {
      emit(TimeSlotsErrorState('unknown_error'));
    }
  }
}

sealed class TimeSlotsState {}

class TimeSlotsInitialState extends TimeSlotsState {}

class TimeSlotsLoadingState extends TimeSlotsState {}

class TimeSlotsSuccessState extends TimeSlotsState {
  final TimeSlotsModel timeSlots;

  TimeSlotsSuccessState(this.timeSlots);
}

class TimeSlotsErrorState extends TimeSlotsState {
  final String error;

  TimeSlotsErrorState(this.error);
}
