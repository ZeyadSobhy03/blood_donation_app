import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_model.dart';

abstract class RequestRepository {
  Future<RequestModel> createRequest({
    required String token,
    required List<String> bloodTypes,
    required String urgency,
    required String requiredBy,
    required int unitsNeeded,
    required String patientType,
    required String contactNumber,
    required String patientDetails,
  });

  Future<RequestModel> createEmergencyRequest({
    required String token,
    required String bloodType,
    required int unitsNeeded,
    required String patientDetails,
  });
}