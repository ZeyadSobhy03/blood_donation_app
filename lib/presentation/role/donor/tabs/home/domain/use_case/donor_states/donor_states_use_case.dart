import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states/donor_states_repositories.dart';

import '../../../data/model/donor_states/donor_state_model.dart';

class DonorStatesUseCase {
  DonorStatesRepositories donorStatesRepositories;

  DonorStatesUseCase({required this.donorStatesRepositories});

  Future<DonorStateModel> getDonorStates() async {
    return await donorStatesRepositories.getDonorStates();
  }
}