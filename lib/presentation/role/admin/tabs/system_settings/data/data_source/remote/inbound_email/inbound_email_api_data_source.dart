import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/inbound_email/inbound_email_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/archived_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/delete_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/inbounded_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/mark_as_read_inbound_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/reply_support_ticket_model.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/resources/api_manger/api_constants.dart';
import '../../../../../../../../../core/utils/dio_error_handler.dart';

class InboundEmailApiDataSource implements InboundEmailRemoteDataSource {
  final Dio dio;
  final AdminHiveDataSource adminHiveDataSource;

  InboundEmailApiDataSource(this.dio, this.adminHiveDataSource);

  @override
  Future<InboundedEmailModel> getInboundedEmail({
    required int page,
    required int limit,
    String? search,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.inboundEmailsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'page': page, 'limit': limit, 'search': search},
      );
      return InboundedEmailModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteInboundEmailModel> deleteInboundEmail({
    required String emailId,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.delete(
        ApiManger.deleteInboundEmailEndpoint(emailId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return DeleteInboundEmailModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MarkAsReadInboundModel> markAsReadInboundEmail({required String emailId})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.markInboundEmailAsReadEndpoint(emailId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
  );
      return MarkAsReadInboundModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ArchivedInboundEmailModel> archivedInboundEmail({required String emailId})async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.patch(
        ApiManger.archiveInboundEmailEndpoint(emailId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return ArchivedInboundEmailModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
    rethrow;
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<ReplySupportTicketModel> replyToSupportTicket({
    required String ticketId,
    required String reply,
  }) async {
    try {
      final token = await adminHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.replyToSupportTicketEndpoint(ticketId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'reply': reply},
      );
      return ReplySupportTicketModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
