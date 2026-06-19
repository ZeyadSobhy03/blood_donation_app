import 'dart:developer';

import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/requests/requests_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_accept_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/request_cancel_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart';

import 'package:dio/dio.dart';

class RequestsApiDataSource implements RequestsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  RequestsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<RequestsModel> getRequests({
    required int limit,
    required int page,

  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.requestsEndPoint,
        queryParameters: {
          'limit': limit,
          'page': page,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log('Fetched requests: ${response.data}');


      return RequestsModel.fromJson(response.data);
    } on DioException catch (e) {
      log('Error fetching requests: ${e.message}');
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RequestAcceptModel> acceptRequest({required String requestId}) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.acceptRequestEndpoint(requestId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RequestAcceptModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RequestCancelModel> cancelRequest({required String requestId}) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.cancelRequestEndpoint(requestId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RequestCancelModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Requests> getRequestById({required String requestId}) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.fetchByRequestIdEndpoint(requestId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Requests.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}