import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/requests/requests_repositories.dart';

import '../../../data/model/requests/request_accept_model.dart';
import '../../../data/model/requests/request_cancel_model.dart';
import '../../../data/model/requests/requests_model.dart';

class RequestsUseCase {

  final RequestsRepositories repository;
  RequestsUseCase({required this.repository});
  Future<RequestsModel>getRequests({
    required int limit,
    required int page,

  })  {
    return repository.getRequests(
      limit: limit,
      page: page,

    );
  }
  Future<RequestAcceptModel>acceptRequest({required String requestId}) {
    return repository.acceptRequest(requestId: requestId);
  }
  Future<RequestCancelModel> cancelRequest({required String requestId}) {
    return repository.cancelRequest(requestId: requestId);
  }
  Future<Requests>getRequestById({
    required String requestId,

  })  {
    return repository.getRequestById(
     requestId: requestId
    );
  }
}