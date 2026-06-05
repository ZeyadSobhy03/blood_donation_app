import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/profile/profile_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/profile/profile_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class ProfileApiDataSource implements ProfileRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  ProfileApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.profileEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
