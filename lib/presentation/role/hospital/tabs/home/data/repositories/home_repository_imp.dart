import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';

import '../data_source/home_remote_data_source.dart';
import '../models/home_dashboard_model.dart';
import '../models/home_activity_model.dart';
import '../models/home_requests_model.dart';
import '../models/home_request_detail_model.dart';
import '../models/home_request_responses_model.dart';
import '../models/home_nearby_donors_model.dart';
import '../models/home_update_request_model.dart';
import 'home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImp({required this.homeRemoteDataSource});

  @override
  Future<HomeDashboardModel> getDashboard({required String token}) {
    return homeRemoteDataSource.getDashboard(token: token);
  }

  @override
  Future<HomeActivityModel> getActivity({required String token}) {
    return homeRemoteDataSource.getActivity(token: token);
  }

  @override
  Future<HospitalProfileModel> getProfile({required String token}) {
    return homeRemoteDataSource.getProfile(token: token);
  }

  @override
  Future<HomeRequestsModel> getRequests({
    required String token,
    int page = 1,
    int limit = 10,
  }) {
    return homeRemoteDataSource.getRequests(
      token: token,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<HomeRequestDetailModel> getRequestDetail({
    required String token,
    required String requestId,
  }) {
    return homeRemoteDataSource.getRequestDetail(
      token: token,
      requestId: requestId,
    );
  }

  @override
  Future<HomeUpdateRequestModel> updateRequestStatus({
    required String token,
    required String requestId,
    required String status,
  }) {
    return homeRemoteDataSource.updateRequestStatus(
      token: token,
      requestId: requestId,
      status: status,
    );
  }

  @override
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
    return homeRemoteDataSource.updateRequest(
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

  @override
  Future<void> cancelRequest({
    required String token,
    required String requestId,
  }) {
    return homeRemoteDataSource.cancelRequest(
      token: token,
      requestId: requestId,
    );
  }

  @override
  Future<HomeRequestResponsesModel> getRequestResponses({
    required String token,
    required String requestId,
  }) {
    return homeRemoteDataSource.getRequestResponses(
      token: token,
      requestId: requestId,
    );
  }

  @override
  Future<HomeNearbyDonorsModel> getNearbyDonorGroups({
    required String token,
    double? lat,
    double? lng,
    double radiusKm = 5,
  }) {
    return homeRemoteDataSource.getNearbyDonorGroups(
      token: token,
      lat: lat,
      lng: lng,
      radiusKm: radiusKm,
    );
  }
}
