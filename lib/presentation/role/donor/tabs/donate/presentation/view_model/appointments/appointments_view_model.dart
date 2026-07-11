
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/book_appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../data/model/appointment/rescheduled_appointment_model.dart';
import '../../../domain/use_case/appointments/appointments_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart'
as appointment_model;

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentsUseCase appointmentsUseCase;

  int _currentPage = 1;
  int _limit = 10;
  bool _hasMoreAppointments = true;
  List<Appointments> _allAppointments = [];

  AppointmentsCubit({required this.appointmentsUseCase})
      : super(AppointmentsInitialState());

  bool get hasMore => _hasMoreAppointments;
  int get currentPage => _currentPage;
  int get limit => _limit;
  List<Appointments> get allAppointments => _allAppointments;

  // Initial fetch
  Future<void> fetchAppointments({
    int page = 1,
    bool fromCancellation = false,
  }) async {
    emit(AppointmentsLoadingState());
    _currentPage = page;
    _allAppointments = [];
    try {
      final response = await appointmentsUseCase.getAppointments(
        page: page,
        limit: _limit,
      );
      if (response.success == true && response.data != null) {
        final newAppointments = response.data?.appointments ?? [];
        _allAppointments = newAppointments;

        if (response.data?.meta != null) {
          _hasMoreAppointments = response.data!.meta!.hasNextPage ?? false;
        } else {
          _hasMoreAppointments = newAppointments.length >= _limit;
        }

        emit(
          AppointmentsSuccessState(
            response,
            fromCancellation: fromCancellation,
          ),
        );
      } else {
        emit(AppointmentsErrorState('failed_to_load_appointments'));
      }
    } on NetworkTimeoutException {
      emit(AppointmentsErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AppointmentsErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(AppointmentsErrorState('unauthorized'));
    } on NotFoundException {
      emit(AppointmentsErrorState('not_found'));
    } on RequestCancelledException {
      emit(AppointmentsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AppointmentsErrorState('unknown_error'));
    } catch (e) {
      emit(AppointmentsErrorState('unknown_error'));
    }
  }

  // Load more appointments (pagination)
  Future<void> loadMoreAppointments() async {
    if (!_hasMoreAppointments) {
      return;
    }

    emit(AppointmentsPaginationLoadingState());
    try {
      final response = await appointmentsUseCase.getAppointments(
        page: _currentPage + 1,
        limit: _limit,
      );
      if (response.success == true && response.data != null) {
        _currentPage++;
        final newAppointments = response.data?.appointments ?? [];
        _allAppointments.addAll(newAppointments);

        // Check if more appointments exist based on meta data
        if (response.data?.meta != null) {
          _hasMoreAppointments = response.data!.meta!.hasNextPage ?? false;
        } else {
          _hasMoreAppointments = newAppointments.length >= _limit;
        }

        // Create updated model with accumulated data
        final updatedData = appointment_model.Data(
          appointments: _allAppointments,
          total: response.data?.total,
          meta: response.data?.meta,
        );

        final updatedResponse = AppointmentModel(
          success: response.success,
          message: response.message,
          data: updatedData,
        );

        emit(AppointmentsPaginationSuccessState(updatedResponse));
      } else {
        emit(AppointmentsPaginationErrorState('failed_to_load_appointments'));
      }
    } on NetworkTimeoutException {
      emit(AppointmentsPaginationErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(
        AppointmentsPaginationErrorState(mapServerErrorToKey(e.serverMessage)),
      );
    } on UnauthorizedException {
      emit(AppointmentsPaginationErrorState('unauthorized'));
    } on NotFoundException {
      emit(AppointmentsPaginationErrorState('not_found'));
    } on RequestCancelledException {
      emit(AppointmentsPaginationErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AppointmentsPaginationErrorState('unknown_error'));
    } catch (e) {
      emit(AppointmentsPaginationErrorState('unknown_error'));
    }
  }

  // Cancel appointment
  Future<void> cancelAppointment(String appointmentId) async {
    emit(CancelAppointmentLoadingState());
    try {
      final result = await appointmentsUseCase.cancelAppointment(
        appointmentId: appointmentId,
      );
      if (result.success == true) {
        await fetchAppointments(fromCancellation: true);
      } else {
        emit(CancelAppointmentErrorState('failed_to_cancel_appointment'));
      }
    } on NetworkTimeoutException {
      emit(CancelAppointmentErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(CancelAppointmentErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(CancelAppointmentErrorState('unauthorized'));
    } on NotFoundException {
      emit(CancelAppointmentErrorState('not_found'));
    } on RequestCancelledException {
      emit(CancelAppointmentErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(CancelAppointmentErrorState('unknown_error'));
    } catch (e) {
      emit(CancelAppointmentErrorState('unknown_error'));
    }
  }

  // Reschedule appointment
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
        emit(
          RescheduleAppointmentErrorState('failed_to_reschedule_appointment'),
        );
      }
    } on NetworkTimeoutException {
      emit(RescheduleAppointmentErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(
        RescheduleAppointmentErrorState(mapServerErrorToKey(e.serverMessage)),
      );
    } on UnauthorizedException {
      emit(RescheduleAppointmentErrorState('unauthorized'));
    } on NotFoundException {
      emit(RescheduleAppointmentErrorState('not_found'));
    } on RequestCancelledException {
      emit(RescheduleAppointmentErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RescheduleAppointmentErrorState('unknown_error'));
    } catch (e) {
      emit(RescheduleAppointmentErrorState('unknown_error'));
    }
  }

  // Book appointment
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
        emit(BookAppointmentErrorState('failed_to_book_appointment'));
      }
    } on NetworkTimeoutException {
      emit(BookAppointmentErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(BookAppointmentErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(BookAppointmentErrorState('unauthorized'));
    } on NotFoundException {
      emit(BookAppointmentErrorState('not_found'));
    } on RequestCancelledException {
      emit(BookAppointmentErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(BookAppointmentErrorState('unknown_error'));
    } catch (e) {
      emit(BookAppointmentErrorState('unknown_error'));
    }
  }

  // Reset pagination
  void resetPagination() {
    _currentPage = 1;
    _hasMoreAppointments = true;
    _allAppointments = [];
    emit(AppointmentsInitialState());
  }
}

// ============================================================================
// STATES
// ============================================================================

sealed class AppointmentsState {}

class AppointmentsInitialState extends AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsSuccessState extends AppointmentsState {
  final AppointmentModel appointments;
  final bool fromCancellation;
  AppointmentsSuccessState(this.appointments, {this.fromCancellation = false});
}

class AppointmentsErrorState extends AppointmentsState {
  final String error;
  AppointmentsErrorState(this.error);
}

class AppointmentsPaginationLoadingState extends AppointmentsState {}

class AppointmentsPaginationSuccessState extends AppointmentsState {
  final AppointmentModel appointments;
  AppointmentsPaginationSuccessState(this.appointments);
}

class AppointmentsPaginationErrorState extends AppointmentsState {
  final String error;
  AppointmentsPaginationErrorState(this.error);
}

class CancelAppointmentLoadingState extends AppointmentsState {}

class CancelAppointmentErrorState extends AppointmentsState {
  final String error;
  CancelAppointmentErrorState(this.error);
}

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