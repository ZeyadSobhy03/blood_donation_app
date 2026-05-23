import 'dart:developer';

import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/time_slots/time_slots_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/time_slots/time_slots_model.dart';
import 'package:dio/dio.dart';

class TimeSlotsApiDataSource implements TimeSlotsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;
  TimeSlotsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<TimeSlotsModel> getTimeSlots({required String date,required String hospitalId}) async{
    try{
      final token = await authLocalDataSource.getAccessToken();

      final response = await dio.get(
        ApiManger.availableSlotsEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: {
          "date": date,
          "hospitalId": hospitalId,
        },
      );
      return TimeSlotsModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Error fetching time slots: $e');
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