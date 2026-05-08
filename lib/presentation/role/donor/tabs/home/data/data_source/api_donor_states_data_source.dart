import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/remote_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_state_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class ApiDonorStatesDataSource implements RemoteDonorStatesDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  ApiDonorStatesDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<DonorStateModel> getDonorStates() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        "https://graduation-project-cy61.onrender.com/donor/stats",

        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data == null) {
          throw Exception(
            'Received null response data from donor states endpoint',
          );
        }
        return DonorStateModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load donor states: '
          'HTTP ${response.statusCode} - ${response.statusMessage ?? "Unknown error"}',
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Error fetching donor states: $e');
    }
  }

  void _handleDioError(DioException e) {
    final _ = switch (e.type) {
      DioExceptionType.connectionTimeout =>
        'Connection timeout - please check your internet',
      DioExceptionType.sendTimeout => 'Send timeout - please try again',
      DioExceptionType.receiveTimeout => 'Receive timeout - please try again',
      DioExceptionType.badResponse => 'Server error: ${e.response?.statusCode}',
      DioExceptionType.cancel => 'Request cancelled',
      DioExceptionType.unknown => 'Network error: ${e.message}',
      _ => 'Unknown error occurred',
    };
  }
}
