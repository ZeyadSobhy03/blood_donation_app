import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donation_eligibility/donation_eligibility_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/donation_eligibility_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/participation_preference_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class DonationEligibilityApiDataSource
    implements DonationEligibilityRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authRemoteDataSource;

  DonationEligibilityApiDataSource(this.dio, this.authRemoteDataSource);

  @override
  Future<DonationEligibilityModel> fetchDonationEligibility() async {
    try {
      final token = await authRemoteDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.donationAvailableEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return DonationEligibilityModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ParticipationPreferenceModel> setParticipation({required bool participation})async {
    try {
      final token = await authRemoteDataSource.getAccessToken();
      final response = await dio.put(
        ApiManger.participationEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'isOptedIn': participation},
      );
      return ParticipationPreferenceModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

}
