import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/rote_admin_key/rote_admin_key_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/rote_admin_key/rote_admin_key_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/rote_admin_key/rote_admin_key_repositories.dart';

class RoteAdminKeyRepositoriesImp implements RoteAdminKeyRepositories {
  final RoteAdminKeyRemoteDataSource roteAdminKeyRemoteDataSource;
  RoteAdminKeyRepositoriesImp({
    required this.roteAdminKeyRemoteDataSource,
  });

  @override
  Future<RoteAdminKeyModel> roteAdminKey({required String id}) {
    return roteAdminKeyRemoteDataSource.roteAdminKey(id: id);
  }

}