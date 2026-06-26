import '../../model/rote_admin_key/rote_admin_key_model.dart';

abstract class RoteAdminKeyRepositories {
  Future<RoteAdminKeyModel> roteAdminKey({
    required String id,
  });
}