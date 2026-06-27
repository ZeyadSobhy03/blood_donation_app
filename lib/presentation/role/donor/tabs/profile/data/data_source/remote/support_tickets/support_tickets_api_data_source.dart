import 'dart:developer';

import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/support_tickets/support_tickets_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:dio/dio.dart';

class SupportTicketsApiDataSource implements SupportTicketsRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authLocalDataSource;

  SupportTicketsApiDataSource(this.dio, this.authLocalDataSource);

  @override
  Future<SupportTicketsModel> getSupportTickets() async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final url = ApiManger.donorSupportTicketsEndpoint;
      log('[SupportTicketsApiDataSource] GET $url');
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      log('[SupportTicketsApiDataSource] Response ${response.statusCode}: ${response.data}');
      return SupportTicketsModel.fromJson(response.data);
    } on DioException catch (e) {
      log('[SupportTicketsApiDataSource] DioException: ${e.message} type=${e.type} status=${e.response?.statusCode} body=${e.response?.data}');
      handleDioError(e);
      rethrow;
    } catch (e, s) {
      log('[SupportTicketsApiDataSource] Error: $e\n$s');
      rethrow;
    }
  }

  @override
  Future<SupportTicketDetailModel> getSupportTicketDetail(String ticketId) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final url = ApiManger.donorSupportTicketDetailEndpoint(ticketId);
      log('[SupportTicketsApiDataSource] GET $url');
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      log('[SupportTicketsApiDataSource] Response ${response.statusCode}: ${response.data}');
      return SupportTicketDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      log('[SupportTicketsApiDataSource] DioException: ${e.message} type=${e.type} status=${e.response?.statusCode} body=${e.response?.data}');
      handleDioError(e);
      rethrow;
    } catch (e, s) {
      log('[SupportTicketsApiDataSource] Error: $e\n$s');
      rethrow;
    }
  }

  @override
  Future<SupportTicketReplyModel> replyToSupportTicket(String ticketId, String reply) async {
    try {
      final token = await authLocalDataSource.getAccessToken();
      final url = ApiManger.donorSupportTicketReplyEndpoint(ticketId);
      log('[SupportTicketsApiDataSource] POST $url');
      final response = await dio.post(
        url,
        data: {'reply': reply},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      log('[SupportTicketsApiDataSource] Response ${response.statusCode}: ${response.data}');
      return SupportTicketReplyModel.fromJson(response.data);
    } on DioException catch (e) {
      log('[SupportTicketsApiDataSource] DioException: ${e.message} type=${e.type} status=${e.response?.statusCode} body=${e.response?.data}');
      handleDioError(e);
      rethrow;
    } catch (e, s) {
      log('[SupportTicketsApiDataSource] Error: $e\n$s');
      rethrow;
    }
  }
}
