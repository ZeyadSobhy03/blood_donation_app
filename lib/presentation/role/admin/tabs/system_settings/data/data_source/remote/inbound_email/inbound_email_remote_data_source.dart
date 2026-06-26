import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/archived_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/delete_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/inbounded_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/mark_as_read_inbound_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/reply_support_ticket_model.dart';

abstract class InboundEmailRemoteDataSource {

  Future<InboundedEmailModel> getInboundedEmail({
    required int page,
    required int limit,
    String? search,
});
  Future <DeleteInboundEmailModel > deleteInboundEmail({
    required String emailId,
  });
  Future<MarkAsReadInboundModel> markAsReadInboundEmail({
    required String emailId,
  });
  Future<ArchivedInboundEmailModel> archivedInboundEmail({
    required String emailId,
  });
  Future<ReplySupportTicketModel> replyToSupportTicket({
    required String ticketId,
    required String reply,
  });

}