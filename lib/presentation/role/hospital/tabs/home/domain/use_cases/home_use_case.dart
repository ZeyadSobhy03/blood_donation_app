import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';

import '../../data/models/home_dashboard_model.dart';
import '../../data/models/home_activity_model.dart';
import '../../data/models/home_requests_model.dart';
import '../../data/models/home_request_detail_model.dart';
import '../../data/models/home_request_responses_model.dart';
import '../../data/models/home_nearby_donors_model.dart';
import '../../data/models/home_update_request_model.dart';
import '../../data/repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository homeRepository;

  HomeUseCase({required this.homeRepository});

  Future<HomeDashboardModel> getDashboard({required String token}) {
    return homeRepository.getDashboard(token: token);
  }

  Future<HomeActivityModel> getActivity({required String token}) {
    return homeRepository.getActivity(token: token);
  }

  Future<HospitalProfileModel> getProfile({required String token}) {
    return homeRepository.getProfile(token: token);
  }

  Future<HomeRequestsModel> getRequests({
    required String token,
    int page = 1,
    int limit = 10,
  }) {
    return homeRepository.getRequests(token: token, page: page, limit: limit);
  }

  Future<HomeRequestDetailModel> getRequestDetail({
    required String token,
    required String requestId,
  }) {
    return homeRepository.getRequestDetail(token: token, requestId: requestId);
  }

  Future<HomeUpdateRequestModel> updateRequestStatus({
    required String token,
    required String requestId,
    required String status,
  }) {
    return homeRepository.updateRequestStatus(
      token: token,
      requestId: requestId,
      status: status,
    );
  }

  Future<HomeUpdateRequestModel> updateRequest({
    required String token,
    required String requestId,
    required String status,
    required List<String> bloodTypes,
    required String urgency,
    required int unitsNeeded,
    required String requiredBy,
    required String patientType,
    required String contactNumber,
    required String patientDetails,
  }) {
    return homeRepository.updateRequest(
      token: token,
      requestId: requestId,
      status: status,
      bloodTypes: bloodTypes,
      urgency: urgency,
      unitsNeeded: unitsNeeded,
      requiredBy: requiredBy,
      patientType: patientType,
      contactNumber: contactNumber,
      patientDetails: patientDetails,
    );
  }

  Future<void> cancelRequest({
    required String token,
    required String requestId,
  }) {
    return homeRepository.cancelRequest(token: token, requestId: requestId);
  }

  Future<HomeRequestResponsesModel> getRequestResponses({
    required String token,
    required String requestId,
  }) {
    return homeRepository.getRequestResponses(token: token, requestId: requestId);
  }

  Future<HomeNearbyDonorsModel> getNearbyDonorGroups({
    required String token,
    double? lat,
    double? lng,
    double radiusKm = 5,
  }) {
    return homeRepository.getNearbyDonorGroups(
      token: token,
      lat: lat,
      lng: lng,
      radiusKm: radiusKm,
    );
  }
}
