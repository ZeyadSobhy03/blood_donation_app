import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/support_tickets/support_tickets_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/support_tickets/support_tickets_repositories.dart';

class SupportTicketsRepositoriesImp implements SupportTicketsRepositories {
  final SupportTicketsRemoteDataSource supportTicketsRemoteDataSource;

  SupportTicketsRepositoriesImp({required this.supportTicketsRemoteDataSource});

  @override
  Future<SupportTicketsModel> getSupportTickets() {
    return supportTicketsRemoteDataSource.getSupportTickets();
  }

  @override
  Future<SupportTicketDetailModel> getSupportTicketDetail(String ticketId) {
    return supportTicketsRemoteDataSource.getSupportTicketDetail(ticketId);
  }

  @override
  Future<SupportTicketReplyModel> replyToSupportTicket(String ticketId, String reply) {
    return supportTicketsRemoteDataSource.replyToSupportTicket(ticketId, reply);
  }
}
