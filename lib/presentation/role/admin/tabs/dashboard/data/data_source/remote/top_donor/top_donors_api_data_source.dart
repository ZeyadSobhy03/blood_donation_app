import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/data_source/remote/top_donor/top_donors_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/top_donor/top_donor_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../../authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';

class TopDonorsApiDataSource implements TopDonorsRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  TopDonorsApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<TopDonorsModel> getTopDonors() async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.topDonorsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return TopDonorsModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  }
