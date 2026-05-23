import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
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

}