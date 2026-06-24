import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/archived_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/delete_inbound_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/inbounded_email_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/inbound_email/mark_as_read_inbound_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/inbound_email/inbound_email_repositories.dart';

import '../../data_source/remote/inbound_email/inbound_email_remote_data_source.dart';

class InboundEmailRepositoriesImp  implements InboundEmailRepositories{
  final InboundEmailRemoteDataSource inboundEmailRemoteDataSource;
  InboundEmailRepositoriesImp({required this.inboundEmailRemoteDataSource});

  @override
  Future<ArchivedInboundEmailModel> archivedInboundEmail({required String emailId}) {
    return inboundEmailRemoteDataSource.archivedInboundEmail(emailId: emailId);


  }

  @override
  Future<DeleteInboundEmailModel> deleteInboundEmail({required String emailId}) {

    return inboundEmailRemoteDataSource.deleteInboundEmail(emailId: emailId);
  }

  @override
  Future<InboundedEmailModel> getInboundedEmail({required int page, required int limit, String? search}) {
    return inboundEmailRemoteDataSource.getInboundedEmail(page: page, limit: limit, search: search);
  }

  @override
  Future<MarkAsReadInboundModel> markAsReadInboundEmail({required String emailId}) {
    return inboundEmailRemoteDataSource.markAsReadInboundEmail(emailId: emailId);
  }

}