import '../../data/repository/appointments_repository.dart';
import '../../data/models/appointment_list_model.dart';
import '../../data/models/appointment_detail_model.dart';
import '../../data/models/verify_appointment_qr_model.dart';
import '../../data/models/verify_appointment_response_model.dart';
import '../../data/models/donation_complete_model.dart';
import '../../data/models/reject_appointment_model.dart';

class AppointmentsUseCase {
  final AppointmentsRepository repository;

  AppointmentsUseCase({required this.repository});

  Future<AppointmentListModel> getAppointments({required String token}) {
    return repository.getAppointments(token: token);
  }

  Future<AppointmentDetailModel> getAppointmentDetail({
    required String token,
    required String appointmentId,
  }) {
    return repository.getAppointmentDetail(
      token: token,
      appointmentId: appointmentId,
    );
  }

  Future<VerifyAppointmentQrModel> verifyQr({
    required String token,
    required String qrToken,
  }) {
    return repository.verifyQr(token: token, qrToken: qrToken);
  }

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
    return repository.verifyAppointment(
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

  Future<DonationCompleteModel> completeDonation({
    required String token,
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  }) {
    return repository.completeDonation(
      token: token,
      appointmentId: appointmentId,
      hemoglobinLevel: hemoglobinLevel,
      weight: weight,
      unitsCollected: unitsCollected,
      notes: notes,
    );
  }

  Future<RejectAppointmentModel> rejectAppointment({
    required String token,
    required String appointmentId,
    required String reason,
  }) {
    return repository.rejectAppointment(
      token: token,
      appointmentId: appointmentId,
      reason: reason,
    );
  }
}
