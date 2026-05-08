import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/schedule_donation_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/nearby_hospital_model.dart';
import 'package:dio/dio.dart';

class ScheduleDonationApiDataSource
    implements ScheduleDonationRemoteDataSource {
  final Dio dio;

  ScheduleDonationApiDataSource(this.dio);

  @override
  Future<NearbyHospitalModel> getNearbyHospitals(
    double latitude,
    double longitude,
      double radius,
  ) async {
    try {
      final response = await dio.get(
        ApiManger.nearbyHospitalsEndpoint,
        queryParameters: {'latitude': latitude, 'longitude': longitude},
      );

      if (response.statusCode == 200) {
        return NearbyHospitalModel.fromJson(response.data);
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Dio error occurred');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
