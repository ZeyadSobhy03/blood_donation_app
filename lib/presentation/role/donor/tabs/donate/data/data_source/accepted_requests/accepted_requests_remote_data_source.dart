import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/accepted_requests/accepted_requests_model.dart';

abstract class AcceptedRequestsRemoteDataSource {

  Future<AcceptedRequestsModel> getAcceptedRequests({
    required int page,
    required int limit,
  });
}