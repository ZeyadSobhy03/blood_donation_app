import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/local/local_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/remote/remote_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_states/donor_state_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states/donor_states_repositories.dart';

class DonorStatesRepositoriesImp implements DonorStatesRepositories {
  final RemoteDonorStatesDataSource remoteDonorStatesDataSource;
  final LocalDonorStatesDataSource localDonorStatesDataSource;

  DonorStatesRepositoriesImp({
    required this.remoteDonorStatesDataSource,
    required this.localDonorStatesDataSource,
  });

  @override
  Future<DonorStateModel> getDonorStates() async {
    try {
      final remoteData = await remoteDonorStatesDataSource.getDonorStates();

      await localDonorStatesDataSource.saveDonorStates(remoteData);

      return remoteData;
    } catch (e) {
      final cachedData = await localDonorStatesDataSource.getDonorStates();

      if (cachedData != null) {
        return cachedData;
      }

      rethrow;
    }
  }
}
