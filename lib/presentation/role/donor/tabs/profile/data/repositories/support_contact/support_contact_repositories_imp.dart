import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_contact/support_contact_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/support_contact/support_contact_repositories.dart';

import '../../data_source/remote/support_contact/support_contact_remote_data_source.dart';

class SupportContactRepositoriesImp implements SupportContactRepositories {
  final SupportContactRemoteDataSource supportContactRemoteDataSource;
  SupportContactRepositoriesImp({required this.supportContactRemoteDataSource});

  @override
  Future<SupportContactModel> supportRequest({required String subject, required String category, required String message})async {
    return await supportContactRemoteDataSource.supportRequest(subject: subject, category: category, message: message);
  }


}