import '../../../model/support_contact/support_contact_model.dart';

abstract class SupportContactRemoteDataSource {
  Future<SupportContactModel> supportRequest({
    required String subject,
    required String category,
    required String message,
  });
}
