import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/accepted_requests/accepted_requests_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/accepted_requests/accepted_requests_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class AcceptedRequestsApiDataSource
    implements AcceptedRequestsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  AcceptedRequestsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<AcceptedRequestsModel> getAcceptedRequests({
    required int page,
    required int limit,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.acceptedRequestsEndpoint,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AcceptedRequestsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
