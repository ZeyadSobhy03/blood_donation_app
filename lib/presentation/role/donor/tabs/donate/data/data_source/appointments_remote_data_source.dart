import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<AppointmentModel> getAppointments();

  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  });
}
