
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/accepted_requests/accepted_requests_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/accepted_requests/accepted_requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/accepted_requests/accepted_requests_repositories.dart';

class AcceptedRequestsRepositoriesImp  implements AcceptedRequestsRepositories{
  final AcceptedRequestsRemoteDataSource acceptedRequestsRemoteDataSource;
  AcceptedRequestsRepositoriesImp({required this.acceptedRequestsRemoteDataSource});

  @override
  Future<AcceptedRequestsModel> getAcceptedRequests({required int page, required int limit}) {
    return acceptedRequestsRemoteDataSource.getAcceptedRequests(page: page, limit: limit);
  }


}