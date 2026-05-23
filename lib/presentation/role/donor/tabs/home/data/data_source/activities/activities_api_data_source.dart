import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/activities/activities_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/activities/activities_model.dart';
import 'package:dio/dio.dart';

class ActivitiesApiDataSource implements ActivitiesRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  ActivitiesApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<ActivitiesModel> getActivities({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.activityHistoryEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return ActivitiesModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}