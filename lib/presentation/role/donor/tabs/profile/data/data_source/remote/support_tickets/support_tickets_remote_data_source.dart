import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';

abstract class SupportTicketsRemoteDataSource {
  Future<SupportTicketsModel> getSupportTickets();
  Future<SupportTicketDetailModel> getSupportTicketDetail(String ticketId);
  Future<SupportTicketReplyModel> replyToSupportTicket(String ticketId, String reply);
}
