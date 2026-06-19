import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_cancel.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_broadcast_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_marked_as_fulfilled_model.dart';

abstract class AdminRequestsRemoteDataSource {
  Future<AdminRequestModel> getAdminRequests({
    required String status,
    required int page,
    required int limit,
});
  Future<RequestMarkedAsFulfilledModel> markRequestAsFulfilled({
    required String requestId,
  });
  Future<AdminRequestCancel> cancelRequest({
    required String requestId,
  });
  Future<RequestBroadcastModel> broadcastRequest({
    required String requestId,
  });
}