import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/rote_admin_key/rote_admin_key_repositories.dart';

import '../../../data/model/rote_admin_key/rote_admin_key_model.dart';

class RoteAdminKeyUseCase {
  final RoteAdminKeyRepositories roteAdminKeyRepositories;
  RoteAdminKeyUseCase({required this.roteAdminKeyRepositories});
  Future<RoteAdminKeyModel> roteAdminKey({
    required String id,
  }) {
    return roteAdminKeyRepositories.roteAdminKey(
      id: id,
    );
  }
}