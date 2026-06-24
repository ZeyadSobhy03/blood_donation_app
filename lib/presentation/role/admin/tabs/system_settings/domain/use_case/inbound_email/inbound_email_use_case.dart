import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/inbound_email/inbound_email_repositories.dart';

import '../../../data/model/inbound_email/archived_inbound_email_model.dart';
import '../../../data/model/inbound_email/delete_inbound_email_model.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';
import '../../../data/model/inbound_email/mark_as_read_inbound_model.dart';

class InboundEmailUseCase {
  final InboundEmailRepositories inboundEmailRepositories;

  InboundEmailUseCase({required this.inboundEmailRepositories});

  Future<InboundedEmailModel> getInboundedEmail({
    required int page,
    required int limit,
    String? search,
  }) {
    return inboundEmailRepositories.getInboundedEmail(
      page: page,
      limit: limit,
      search: search,
    );
  }

  Future<DeleteInboundEmailModel> deleteInboundEmail({
    required String emailId,
  }) {
    return inboundEmailRepositories.deleteInboundEmail(emailId: emailId);
  }

  Future<MarkAsReadInboundModel> markAsReadInboundEmail({
    required String emailId,
  }) {
    return inboundEmailRepositories.markAsReadInboundEmail(emailId: emailId);
  }

  Future<ArchivedInboundEmailModel> archivedInboundEmail({
    required String emailId,
  }) {
    return inboundEmailRepositories.archivedInboundEmail(emailId: emailId);
  }
}
