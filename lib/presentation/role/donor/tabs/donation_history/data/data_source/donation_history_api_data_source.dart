import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/data_source/donation_history_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/model/donation_history_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/utils/dio_error_handler.dart';

class DonationHistoryApiDataSource implements DonationHistoryRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;

  DonationHistoryApiDataSource(this.dio, this.authHiveDataSource);

  @override
  Future<DonationHistoryModel> fetchDonationHistory({
    required int page,
   required int limit,
  }) async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.historyEndpoint,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return DonationHistoryModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
