import '../model/appointment_cancelled_model.dart';
import '../model/appointment_model.dart';

abstract class AppointmentsRepositories {
  Future<AppointmentModel> getAppointments();
  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  });

}