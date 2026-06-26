import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/rote_admin_key/rote_admin_key_model.dart';

abstract class RoteAdminKeyRemoteDataSource {
  Future<RoteAdminKeyModel> roteAdminKey({
    required String id,
  });
}