import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/fcm/fcm_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/fcm/fcm_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class FcmApiDataSource implements FcmRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;
  FcmApiDataSource(this.dio,this.authLocalDataSource);
  @override
  Future<FcmModel> saveFcmToken(String token)async {
    try {
      final accessToken = await authLocalDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.saveFcmTokenEndpoint,
        data: {'fcmToken': token},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),


      );
      return FcmModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }



}