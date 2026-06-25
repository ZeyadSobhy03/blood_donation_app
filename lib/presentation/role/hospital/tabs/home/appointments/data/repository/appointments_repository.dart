import '../models/appointment_list_model.dart';
import '../models/appointment_detail_model.dart';
import '../models/verify_appointment_qr_model.dart';
import '../models/verify_appointment_response_model.dart';
import '../models/donation_complete_model.dart';
import '../models/reject_appointment_model.dart';

abstract class AppointmentsRepository {
  Future<AppointmentListModel> getAppointments({required String token});
  Future<AppointmentDetailModel> getAppointmentDetail({
    required String token,
    required String appointmentId,
  });
  Future<VerifyAppointmentQrModel> verifyQr({
    required String token,
    required String qrToken,
  });
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
  });
  Future<DonationCompleteModel> completeDonation({
    required String token,
    required String appointmentId,
    required double hemoglobinLevel,
    required double weight,
    required int unitsCollected,
    required String notes,
  });
  Future<RejectAppointmentModel> rejectAppointment({
    required String token,
    required String appointmentId,
    required String reason,
  });
}
