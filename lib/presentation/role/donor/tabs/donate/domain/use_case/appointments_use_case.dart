import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/appointments_repositories.dart';

import '../../data/model/appointment_cancelled_model.dart';
import '../../data/model/appointment_model.dart';
import '../../data/model/book_appointment_model.dart';

class AppointmentsUseCase {
  AppointmentsRepositories appointmentsRepositories;
  AppointmentsUseCase({required this.appointmentsRepositories});
  Future<AppointmentModel> getAppointments(){
    return appointmentsRepositories.getAppointments();
  }
  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  }) {
    return appointmentsRepositories.cancelAppointment(appointmentId: appointmentId);
  }
  Future<BookAppointmentModel>bookAppointment({
    required String hospitalId,
    required String appointmentDate,
    required String donationType,
    required  String notes

  })  {
    return appointmentsRepositories.bookAppointment(
        hospitalId: hospitalId,
        appointmentDate: appointmentDate,
        donationType: donationType,
        notes: notes
    );
  }


}