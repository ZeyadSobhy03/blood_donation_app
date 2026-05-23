import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';

class AppointmentsApiDataSource implements AppointmentsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  AppointmentsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<AppointmentModel> getAppointments() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.appointmentsEndpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Error fetching appointments: $e');
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

  @override
  Future<AppointmentCancelledModel> cancelAppointment({required String appointmentId})async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final response = await dio.delete(
        ApiManger.cancelAppointmentEndpoint(appointmentId),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return AppointmentCancelledModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Error cancelling appointment: $e');
    }
  }
}
