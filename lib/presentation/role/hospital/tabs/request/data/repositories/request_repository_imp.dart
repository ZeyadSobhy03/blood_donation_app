import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/data_source/request_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/model/request_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/data/repositories/request_repository.dart';

class RequestRepositoryImp implements RequestRepository {
  final RequestRemoteDataSource requestRemoteDataSource;

  RequestRepositoryImp({required this.requestRemoteDataSource});

  @override
  Future<RequestModel> createRequest({
    required String token,
    required List<String> bloodTypes,
    required String urgency,
    required String requiredBy,
    required int unitsNeeded,
    required String patientType,
    required String contactNumber,
    required String patientDetails,
  }) {
    return requestRemoteDataSource.createRequest(
      token: token,
      bloodTypes: bloodTypes,
      urgency: urgency,
      requiredBy: requiredBy,
      unitsNeeded: unitsNeeded,
      patientType: patientType,
      contactNumber: contactNumber,
      patientDetails: patientDetails,
    );
  }

  @override
  Future<RequestModel> createEmergencyRequest({
    required String token,
    required String bloodType,
    required int unitsNeeded,
    required String patientDetails,
  }) {
    return requestRemoteDataSource.createEmergencyRequest(
      token: token,
      bloodType: bloodType,
      unitsNeeded: unitsNeeded,
      patientDetails: patientDetails,
    );
  }
}