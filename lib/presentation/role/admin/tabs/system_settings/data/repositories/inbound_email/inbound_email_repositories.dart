import '../../model/inbound_email/archived_inbound_email_model.dart';
import '../../model/inbound_email/delete_inbound_email_model.dart';
import '../../model/inbound_email/inbounded_email_model.dart';
import '../../model/inbound_email/mark_as_read_inbound_model.dart';
import '../../model/inbound_email/reply_support_ticket_model.dart';

abstract class InboundEmailRepositories {

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