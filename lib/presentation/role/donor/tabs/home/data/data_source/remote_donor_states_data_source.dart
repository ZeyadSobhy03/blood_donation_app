import '../model/donor_state_model.dart';

abstract class RemoteDonorStatesDataSource {
  Future<DonorStateModel> getDonorStates();
}