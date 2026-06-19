import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_cancel.dart';

import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_broadcast_model.dart';

import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_marked_as_fulfilled_model.dart';

import '../data_source/remote/admin_requests_remote_data_source.dart';
import '../model/admin_request_model.dart';
import 'admin_requests_repositories.dart';

class AdminRequestsRepositoriesImp implements AdminRequestsRepositories {
  final AdminRequestsRemoteDataSource adminRequestsRemoteDataSource;

  AdminRequestsRepositoriesImp({required this.adminRequestsRemoteDataSource});

  @override
  Future<AdminRequestModel> getAdminRequests({
    required String status,
    required int page,
    required int limit,
  }) async {
    return await adminRequestsRemoteDataSource.getAdminRequests(
      status: status,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<RequestBroadcastModel> broadcastRequest({required String requestId}) {
    return adminRequestsRemoteDataSource.broadcastRequest(requestId: requestId);
  }

  @override
  Future<AdminRequestCancel> cancelRequest({required String requestId}) {
    return adminRequestsRemoteDataSource.cancelRequest(requestId: requestId);
  }

  @override
  Future<RequestMarkedAsFulfilledModel> markRequestAsFulfilled({required String requestId}) {
    return adminRequestsRemoteDataSource.markRequestAsFulfilled(requestId: requestId);
  }
}
