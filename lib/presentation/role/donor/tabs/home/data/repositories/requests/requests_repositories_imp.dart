import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_accept_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_by_id_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_cancel_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/requests/requests_repositories.dart';

import '../../data_source/requests/requests_remote_data_source.dart';

class RequestsRepositoriesImp  implements RequestsRepositories{
  final RequestsRemoteDataSource requestsRemoteDataSource;
  RequestsRepositoriesImp({required this.requestsRemoteDataSource});

  @override
  Future<RequestsModel> getRequests({required int limit, required int page}) {
return requestsRemoteDataSource.getRequests(limit: limit, page: page);
  }

  @override
  Future<RequestAcceptModel> acceptRequest({required String requestId}) {
    return requestsRemoteDataSource.acceptRequest(requestId: requestId);
  }

  @override
  Future<RequestCancelModel> cancelRequest({required String requestId}) {
    return requestsRemoteDataSource.cancelRequest(requestId: requestId);
  }

  @override
  Future<RequestByIdModel> getRequestById({required String requestId}) {
    return requestsRemoteDataSource.getRequestById(requestId: requestId);
  }


}