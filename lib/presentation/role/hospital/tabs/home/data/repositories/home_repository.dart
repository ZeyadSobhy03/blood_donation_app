import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';

import '../models/home_dashboard_model.dart';
import '../models/home_activity_model.dart';
import '../models/home_requests_model.dart';
import '../models/home_request_detail_model.dart';
import '../models/home_request_responses_model.dart';
import '../models/home_nearby_donors_model.dart';
import '../models/home_update_request_model.dart';

abstract class HomeRepository {
  Future<HomeDashboardModel> getDashboard({required String token});

  Future<HomeActivityModel> getActivity({required String token});

  Future<HospitalProfileModel> getProfile({required String token});

  Future<HomeRequestsModel> getRequests({
    required String token,
    int page,
    int limit,
  });

  Future<HomeRequestDetailModel> getRequestDetail({
    required String token,
    required String requestId,
  });

  Future<HomeUpdateRequestModel> updateRequestStatus({
    required String token,
    required String requestId,
    required String status,
  });

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
  });

  Future<void> cancelRequest({
    required String token,
    required String requestId,
  });

  Future<HomeRequestResponsesModel> getRequestResponses({
    required String token,
    required String requestId,
  });

  Future<HomeNearbyDonorsModel> getNearbyDonorGroups({
    required String token,
    double? lat,
    double? lng,
    double radiusKm,
  });
}
