import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/support_tickets/support_tickets_repositories.dart';

class SupportTicketsUseCase {
  final SupportTicketsRepositories supportTicketsRepositories;

  SupportTicketsUseCase({required this.supportTicketsRepositories});

  Future<SupportTicketsModel> getSupportTickets() {
    return supportTicketsRepositories.getSupportTickets();
  }

  Future<SupportTicketDetailModel> getSupportTicketDetail(String ticketId) {
    return supportTicketsRepositories.getSupportTicketDetail(ticketId);
  }

  Future<SupportTicketReplyModel> replyToSupportTicket(String ticketId, String reply) {
    return supportTicketsRepositories.replyToSupportTicket(ticketId, reply);
  }
}
