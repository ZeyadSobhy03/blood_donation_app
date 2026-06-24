import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/book_appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/rescheduled_appointment_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<AppointmentModel> getAppointments(
  {
    required int limit,
    required int page,
}
      );

  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  });
  Future<BookAppointmentModel>bookAppointment({
    required String hospitalId,
    required String appointmentDate,
    required String donationType,
    required  String notes

  });
  Future<RescheduledAppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required String appointmentDate,
    required String donationType,
    required  String notes
  });

}
