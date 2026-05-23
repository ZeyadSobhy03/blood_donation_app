import '../../model/donor_states/donor_state_model.dart';

abstract class DonorStatesRepositories {
  Future<DonorStateModel> getDonorStates();

}