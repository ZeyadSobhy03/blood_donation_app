import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/repositories/admin_requests_repositories.dart';

import '../../data/model/admin_request_cancel.dart';
import '../../data/model/admin_request_model.dart';
import '../../data/model/request_broadcast_model.dart';
import '../../data/model/request_marked_as_fulfilled_model.dart';

class AdminRequestsUseCase {
  final AdminRequestsRepositories adminRequestsRepositories;

  AdminRequestsUseCase({required this.adminRequestsRepositories});

  Future<AdminRequestModel> getAdminRequests({
    required String status,
    required int page,
    required int limit,
  }) async {
    return await adminRequestsRepositories.getAdminRequests(
      status: status,
      page: page,
      limit: limit,
    );
  }

  Future<RequestMarkedAsFulfilledModel> markRequestAsFulfilled({
    required String requestId,
  }) {
    return adminRequestsRepositories.markRequestAsFulfilled(
      requestId: requestId,
    );
  }

  Future<AdminRequestCancel> cancelRequest({required String requestId}) {
    return adminRequestsRepositories.cancelRequest(requestId: requestId);
  }

  Future<RequestBroadcastModel> broadcastRequest({required String requestId}) {
    return adminRequestsRepositories.broadcastRequest(requestId: requestId);
  }
}
