import '../data_source/appointments_api_data_source.dart';
import '../models/appointment_list_model.dart';
import '../models/appointment_detail_model.dart';
import '../models/verify_appointment_qr_model.dart';
import '../models/verify_appointment_response_model.dart';
import '../models/donation_complete_model.dart';
import '../models/reject_appointment_model.dart';
import 'appointments_repository.dart';

class AppointmentsRepositoryImp implements AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;

  AppointmentsRepositoryImp({required this.remoteDataSource});

  @override
  Future<AppointmentListModel> getAppointments({required String token}) {
    return remoteDataSource.getAppointments(token: token);
  }

  @override
  Future<AppointmentDetailModel> getAppointmentDetail({
    required String token,
    required String appointmentId,
  }) {
    return remoteDataSource.getAppointmentDetail(
      token: token,
      appointmentId: appointmentId,
    );
  }

  @override
  Future<VerifyAppointmentQrModel> verifyQr({
    required String token,
    required String qrToken,
  }) {
    return remoteDataSource.verifyQr(token: token, qrToken: qrToken);
  }

  @override
  Future<VerifyAppointmentResponseModel> verifyAppointment({
    required String token,
    required String appointmentId,
    required String verificationSessionId,
    required bool idVerified,
    required bool questionnaireCompleted,
    required bool consentSigned,
    required bool screeningCompleted,
    required bool disqualifyingDiseaseFound,
    required List<String> disqualifyingDiseases,
    required String notes,
  }) {
    return remoteDataSource.verifyAppointment(
      token: token,
      appointmentId: appointmentId,
      verificationSessionId: verificationSessionId,
      idVerified: idVerified,
      questionnaireCompleted: questionnaireCompleted,
      consentSigned: consentSigned,
      screeningCompleted: screeningCompleted,
      disqualifyingDiseaseFound: disqualifyingDiseaseFound,
      disqualifyingDiseases: disqualifyingDiseases,
      notes: notes,
    );
  }

  @override
  Future<DonationCompleteModel> completeDonation({
    required String token,
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  }) {
    return remoteDataSource.completeDonation(
      token: token,
      appointmentId: appointmentId,
      hemoglobinLevel: hemoglobinLevel,
      weight: weight,
      unitsCollected: unitsCollected,
      notes: notes,
    );
  }

  @override
  Future<RejectAppointmentModel> rejectAppointment({
    required String token,
    required String appointmentId,
    required String reason,
  }) {
    return remoteDataSource.rejectAppointment(
      token: token,
      appointmentId: appointmentId,
      reason: reason,
    );
  }
}
