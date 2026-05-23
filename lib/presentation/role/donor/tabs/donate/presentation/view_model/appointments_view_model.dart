import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/appointments_use_case.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsUseCase appointmentsUseCase;

  AppointmentsCubit({
    required this.appointmentsUseCase,
  }) : super(AppointmentsInitialState());

  Future<void> fetchAppointments() async {
    try {
      emit(AppointmentsLoadingState());

      final appointments = await appointmentsUseCase.getAppointments();

      if (appointments.success == true && appointments.data != null) {
        emit(AppointmentsSuccessState(appointments));
      } else {
        emit(AppointmentsErrorState('Failed to load appointments'));
      }
    } catch (e) {
      emit(AppointmentsErrorState(e.toString()));
    }
  }
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      emit(AppointmentsLoadingState());

      final result = await appointmentsUseCase.cancelAppointment(appointmentId: appointmentId);

      if (result.success == true) {
        await fetchAppointments();
      } else {
        emit(AppointmentsErrorState('Failed to cancel appointment'));
      }
    } catch (e) {
      emit(AppointmentsErrorState(e.toString()));
    }}

}

sealed class AppointmentsState {}

class AppointmentsInitialState extends AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsSuccessState extends AppointmentsState {
  final AppointmentModel appointments;

  AppointmentsSuccessState(this.appointments);
}

class AppointmentsErrorState extends AppointmentsState {
  final String error;

  AppointmentsErrorState(this.error);
}
