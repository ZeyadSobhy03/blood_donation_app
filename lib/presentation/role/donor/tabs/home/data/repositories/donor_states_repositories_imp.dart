import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/remote_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_state_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states_repositories.dart';

class DonorStatesRepositoriesImp implements DonorStatesRepositories {
  RemoteDonorStatesDataSource remoteDonorStatesDataSource;

  DonorStatesRepositoriesImp({required this.remoteDonorStatesDataSource});

  @override
  Future<DonorStateModel> getDonorStates() async {
    return await remoteDonorStatesDataSource.getDonorStates();
  }
}
