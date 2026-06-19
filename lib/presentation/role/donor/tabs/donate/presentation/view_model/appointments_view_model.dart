import 'dart:developer';

import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/book_appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../core/utils/error_localizer.dart';
import '../../data/model/rescheduled_appointment_model.dart';
import '../../domain/use_case/appointments_use_case.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsUseCase appointmentsUseCase;

  AppointmentsCubit({
    required this.appointmentsUseCase,
  }) : super(AppointmentsInitialState());

  Future<void> fetchAppointments() async {
    emit(AppointmentsLoadingState());
    try {
      final appointments = await appointmentsUseCase.getAppointments();
      if (appointments.success == true && appointments.data != null) {
        emit(AppointmentsSuccessState(appointments));
      } else {
        emit(AppointmentsErrorState('failed_to_load_appointments'));
      }
    } on NetworkTimeoutException {
      emit(AppointmentsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AppointmentsErrorState(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(AppointmentsErrorState('unauthorized'));
    } on NotFoundException {
      emit(AppointmentsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AppointmentsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AppointmentsErrorState('unknown_error'));
    } catch (e) {
      log('Unknown error while fetching appointments: $e');
      emit(AppointmentsErrorState('unknown_error'));
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    emit(CancelAppointmentLoadingState());
    try {
      final result = await appointmentsUseCase.cancelAppointment(
        appointmentId: appointmentId,
      );
      if (result.success == true) {
        await fetchAppointments();
      } else {
        emit(AppointmentsErrorState('failed_to_cancel_appointment'));
      }
    } on NetworkTimeoutException {
      emit(AppointmentsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AppointmentsErrorState(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(AppointmentsErrorState('unauthorized'));
    } on NotFoundException {
      emit(AppointmentsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AppointmentsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      log('Unknown network error while cancelling appointment');
      emit(AppointmentsErrorState('unknown_error'));
    } catch (e) {
      log('Unknown error while cancelling appointment: $e');
      emit(AppointmentsErrorState('unknown_error'));
    }
  }
  Future<void> rescheduleAppointment({
    required String appointmentId,
    required String appointmentDate,
    required String donationType,
    required String notes,
  }) async {
    emit(RescheduleAppointmentLoadingState());
    try {
      final result = await appointmentsUseCase.rescheduleAppointment(
        appointmentId: appointmentId,
        appointmentDate: appointmentDate,
        donationType: donationType,
        notes: notes,
      );
      if (result.success == true) {
        emit(RescheduleAppointmentSuccessState(result));
        await fetchAppointments();
      } else {
        emit(RescheduleAppointmentErrorState('failed_to_reschedule_appointment'));
      }
    } on NetworkTimeoutException {
      emit(RescheduleAppointmentErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(RescheduleAppointmentErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RescheduleAppointmentErrorState('unauthorized'));
    } on NotFoundException {
      emit(RescheduleAppointmentErrorState('not_found'));
    } on RequestCancelledException {
      emit(RescheduleAppointmentErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RescheduleAppointmentErrorState('unknown_error'));
    } catch (e) {
      log('Unknown error while rescheduling appointment: $e');
      emit(RescheduleAppointmentErrorState('unknown_error'));
    }
  }

  Future<void> bookAppointment({
    required String hospitalId,
    required String appointmentDate,
    required String donationType,
    required String notes,
  }) async {
    emit(BookAppointmentLoadingState());
    try {
      final result = await appointmentsUseCase.bookAppointment(
        hospitalId: hospitalId,
        appointmentDate: appointmentDate,
        donationType: donationType,
        notes: notes,
      );
      if (result.success == true) {
        emit(BookAppointmentSuccessState(result));
      } else {
        log('Failed to book appointment: ${result.message}');
        emit(BookAppointmentErrorState('failed_to_book_appointment'));
      }
    } on NetworkTimeoutException {
      log('Network timeout while booking appointment');
      emit(BookAppointmentErrorState('network_timeout'));
    } on ServerException catch (e) {
      log('Server error while booking appointment: ${e.serverMessage}');
      emit(BookAppointmentErrorState(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(BookAppointmentErrorState('unauthorized'));
    } on NotFoundException {
      emit(BookAppointmentErrorState('not_found'));
    } on RequestCancelledException {
      emit(BookAppointmentErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(BookAppointmentErrorState('unknown_error'));
    } catch (e) {
      log('Unknown error while booking appointment: $e');
      emit(BookAppointmentErrorState('unknown_error'));
    }
  }
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

class CancelAppointmentLoadingState extends AppointmentsState {}

class BookAppointmentLoadingState extends AppointmentsState {}
class BookAppointmentSuccessState extends AppointmentsState {
  final BookAppointmentModel bookAppointmentModel;
  BookAppointmentSuccessState(this.bookAppointmentModel);
}
class BookAppointmentErrorState extends AppointmentsState {
  final String error;
  BookAppointmentErrorState(this.error);
}
class RescheduleAppointmentLoadingState extends AppointmentsState {}

class RescheduleAppointmentSuccessState extends AppointmentsState {
  final RescheduledAppointmentModel rescheduledAppointmentModel;
  RescheduleAppointmentSuccessState(this.rescheduledAppointmentModel);
}

class RescheduleAppointmentErrorState extends AppointmentsState {
  final String error;
  RescheduleAppointmentErrorState(this.error);
}