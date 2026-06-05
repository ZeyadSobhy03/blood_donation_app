import '../model/appointment_cancelled_model.dart';
import '../model/appointment_model.dart';
import '../model/book_appointment_model.dart';

abstract class AppointmentsRepositories {
  Future<AppointmentModel> getAppointments();
  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  });
  Future<BookAppointmentModel>bookAppointment({
    required String hospitalId,
    required String appointmentDate,
    required String donationType,
    required  String notes

  });

}