import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/rote_admin_key/rote_admin_key_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/rote_admin_key/rote_admin_key_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';

class RoteAdminKeyApiDataSource implements RoteAdminKeyRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;
  RoteAdminKeyApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<RoteAdminKeyModel> roteAdminKey({required String id}) async{
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.rotateAdminKeyEndpoint(id),
        options: Options(
          headers: {
            'Content-Type': 'application/json', 
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RoteAdminKeyModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
}

  }
  
