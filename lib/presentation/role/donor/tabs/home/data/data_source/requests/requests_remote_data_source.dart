import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_cancel_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';

import '../../model/requests/request_accept_model.dart';

abstract class RequestsRemoteDataSource {

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