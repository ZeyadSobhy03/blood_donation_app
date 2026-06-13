import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/data_source/remote/analytics/analytics_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_donations_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class AnalyticsApiDataSource implements AnalyticsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AnalyticsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AnalyticsModel> getAnalytics() async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.analyticsDashboardEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AnalyticsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AnalyticsDonationsModel> getAnalyticsDonations()async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.analyticsDonationsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AnalyticsDonationsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
