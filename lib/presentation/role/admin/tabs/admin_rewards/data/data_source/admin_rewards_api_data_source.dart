import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/data_source/admin_rewards_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/model/admin_rewards_data_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../core/utils/dio_error_handler.dart';

class AdminRewardsApiDataSource implements AdminRewardsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  AdminRewardsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<AdminRewardsDataModel> getAdminRewardsData({
    String? query,
    int? limit,
    int? adjustments,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.adminRewardsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {
          'query': query,
          'limit': limit,
          'adjustments': adjustments,
        },
      );
      return AdminRewardsDataModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
