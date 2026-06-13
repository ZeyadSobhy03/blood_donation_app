import '../../model/requests/request_accept_model.dart';
import '../../model/requests/request_cancel_model.dart';
import '../../model/requests/requests_model.dart';

abstract class RequestsRepositories {


  Future<RequestsModel>getRequests({
    required int limit,
    required int page,

  });
  Future<RequestAcceptModel>acceptRequest({required String requestId});
  Future<RequestCancelModel> cancelRequest({required String requestId});
  Future<Requests>getRequestById({
    required String requestId,

  });

}