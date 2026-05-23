
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/time_slots/time_slots_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        emit(TimeSlotsErrorState('Failed to load time slots'));
      }
    } catch (e) {

      emit(TimeSlotsErrorState(e.toString()));
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
