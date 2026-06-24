import '../../model/accepted_requests/accepted_requests_model.dart';

abstract class AcceptedRequestsRepositories {

  Future<AcceptedRequestsModel> getAcceptedRequests({
    required int page,
    required int limit,
  });
}