
import 'dart:developer';

import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_cancelled_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/book_appointment_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/rescheduled_appointment_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/utils/dio_error_handler.dart';
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
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppointmentCancelledModel> cancelAppointment({
    required String appointmentId,
  }) async {
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
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookAppointmentModel> bookAppointment({
    required String hospitalId,
    required String appointmentDate,
    required String donationType,
    required String notes,
  }) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final body = {
        'hospitalId': hospitalId,
        'appointmentDate': appointmentDate,
        'donationType': donationType,
        'notes': notes,
      };
      final response = await dio.post(
        ApiManger.bookAppointmentEndpoint,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return BookAppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RescheduledAppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required String appointmentDate,
    required String donationType,
    required String notes,
  })async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final body = {
        'appointmentDate': appointmentDate,
        'donationType': donationType,
        'notes': notes,
      };
      log(body.toString());
      final response = await dio.patch(
        ApiManger.rescheduleAppointmentEndpoint(appointmentId),
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return RescheduledAppointmentModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
