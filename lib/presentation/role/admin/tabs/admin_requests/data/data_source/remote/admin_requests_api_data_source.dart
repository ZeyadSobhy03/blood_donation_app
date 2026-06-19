import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/data_source/remote/admin_requests_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_cancel.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/admin_request_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_broadcast_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/model/request_marked_as_fulfilled_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';

class AdminRequestsApiDataSource implements AdminRequestsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AdminRequestsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminRequestModel> getAdminRequests({
    required String status,
    required int page,
    required int limit,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminRequestsEndpoint,
        queryParameters: {'status': status, 'page': page, 'limit': limit},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AdminRequestModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RequestBroadcastModel> broadcastRequest({required String requestId})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.broadcastRequestEndpoint(requestId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RequestBroadcastModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e)
{
rethrow;

}}

  @override
  Future<AdminRequestCancel> cancelRequest({required String requestId})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.adminCancelRequestsEndpoint(requestId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AdminRequestCancel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RequestMarkedAsFulfilledModel> markRequestAsFulfilled({required String requestId}) async{

    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.fulfillRequestEndpoint(requestId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RequestMarkedAsFulfilledModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
