import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/remote/remote_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_states/donor_state_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class ApiDonorStatesDataSource implements RemoteDonorStatesDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  ApiDonorStatesDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<DonorStateModel> getDonorStates() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.donorSates,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return DonorStateModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
