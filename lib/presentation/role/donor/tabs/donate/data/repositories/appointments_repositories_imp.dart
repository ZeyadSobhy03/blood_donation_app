import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/book_appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/rescheduled_appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/appointments_repositories.dart';

class AppointmentsRepositoriesImp implements AppointmentsRepositories {
  final AppointmentsRemoteDataSource appointmentsRemoteDataSource;
  AppointmentsRepositoriesImp({required this.appointmentsRemoteDataSource});
  @override
  Future<AppointmentModel> getAppointments() {
    return appointmentsRemoteDataSource.getAppointments();
  }

  @override
  Future<AppointmentCancelledModel> cancelAppointment({required String appointmentId}) {
    return appointmentsRemoteDataSource.cancelAppointment(appointmentId: appointmentId);
  }

  @override
  Future<BookAppointmentModel> bookAppointment({required String hospitalId, required String appointmentDate, required String donationType, required String notes}) {
    return appointmentsRemoteDataSource.bookAppointment(hospitalId: hospitalId, appointmentDate: appointmentDate, donationType: donationType, notes: notes);
  }

  @override
  Future<RescheduledAppointmentModel> rescheduleAppointment({required String appointmentId, required String appointmentDate, required String donationType, required String notes}) {
    return appointmentsRemoteDataSource.rescheduleAppointment(appointmentId: appointmentId, appointmentDate: appointmentDate, donationType: donationType, notes: notes);
  }



}