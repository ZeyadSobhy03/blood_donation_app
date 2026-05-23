import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_states/donor_state_model.dart';

abstract class LocalDonorStatesDataSource {
  Future<void> init();
  Future<void> saveDonorStates(DonorStateModel donorStateModel);
  Future<DonorStateModel?> getDonorStates();
  Future<void> clearDonorStates();
}

