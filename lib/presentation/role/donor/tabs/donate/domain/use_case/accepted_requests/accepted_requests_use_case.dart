import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/accepted_requests/accepted_requests_repositories.dart';

import '../../../data/model/accepted_requests/accepted_requests_model.dart';

class AcceptedRequestsUseCase {
  final AcceptedRequestsRepositories acceptedRequestsRepositories;

  AcceptedRequestsUseCase({required this.acceptedRequestsRepositories});

  Future<AcceptedRequestsModel> getAcceptedRequests({
    required int page,
    required int limit,
  }) {
    return acceptedRequestsRepositories.getAcceptedRequests(
      page: page,
      limit: limit,
    );
  }
}
