import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/support_contact/support_contact_repositories.dart';

import '../../../data/model/support_contact/support_contact_model.dart';

class SupportContactUseCase {
  final SupportContactRepositories supportContactRepositories;

  SupportContactUseCase({required this.supportContactRepositories});

  Future<SupportContactModel> supportRequest({
    required String subject,
    required String category,
    required String message,
  }) async {
    return await supportContactRepositories.supportRequest(
      subject: subject,
      category: category,
      message: message,
    );
  }
}
