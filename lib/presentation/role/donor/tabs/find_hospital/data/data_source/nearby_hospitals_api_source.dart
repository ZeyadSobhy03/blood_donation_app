import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/data_source/nearby_hospitals_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/model/nearby_hospitals.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/utils/dio_error_handler.dart';
import '../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class NearbyHospitalsApiSource implements NearbyHospitalsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  NearbyHospitalsApiSource(this.dio, this.authLocalDataSource);

  @override
  Future<NearbyHospitals> getNearbyHospitals({
    required double latitude,
    required double longitude,
    double radius = 10,
    String? search,
    String? bloodType,
    String sortBy = 'distance',
    String order = 'asc',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.nearbyHospitals,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          "lat": latitude,
          "lng": longitude,
          "radius": radius,
          "search": search,
          "bloodType": bloodType,
          "order": order,
          "page": page,
          "limit": limit,
        },
      );
      return NearbyHospitals.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NearbyHospitals> searchNearbyHospitals({
    required String query,
    String? bloodType,
    bool? availableOnly,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.searchNearbyHospitals,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          "search": query,
          "bloodType": bloodType,
          "availableOnly": availableOnly,
          "page": page,
          "limit": limit,
        },
      );
      return NearbyHospitals.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
