import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_accept_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_cancel_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/requests/requests_repositories.dart';

import '../../data_source/requests/requests_remote_data_source.dart';

class RequestsRepositoriesImp  implements RequestsRepositories{
  final RequestsRemoteDataSource requestsRemoteDataSource;
  RequestsRepositoriesImp({required this.requestsRemoteDataSource});

  @override
  Future<RequestsModel> getRequests({required double latitude, required double longitude, required String bloodType, required int radius}) {
    return requestsRemoteDataSource.getRequests(latitude: latitude, longitude: longitude, bloodType: bloodType, radius: radius);
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
  Future<Requests> getRequestById({required String requestId}) {
    return requestsRemoteDataSource.getRequestById(requestId: requestId);
  }


}