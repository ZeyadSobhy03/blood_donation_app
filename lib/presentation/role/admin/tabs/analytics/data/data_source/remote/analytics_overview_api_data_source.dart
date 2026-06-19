import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/data_source/remote/analytics_overview_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/model/analytics_overview_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';

class AnalyticsOverviewApiDataSource
    implements AnalyticsOverviewRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AnalyticsOverviewApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AnalyticsOverviewModel> getAnalyticsOverview() async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.analyticsOverviewEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AnalyticsOverviewModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
