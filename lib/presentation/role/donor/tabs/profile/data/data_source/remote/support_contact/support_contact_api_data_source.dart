import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/support_contact/support_contact_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_contact/support_contact_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class SupportContactApiDataSource implements SupportContactRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;

  SupportContactApiDataSource(this.dio, this.authHiveDataSource);

  @override
  Future<SupportContactModel> supportRequest({
    required String subject,
    required String category,
    required String message,
  }) async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.supportRequestsEndpoint,
        data: {'subject': subject, 'category': category, 'message': message},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return SupportContactModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
