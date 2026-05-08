import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/api_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/donor_states_use_case.dart';

class DonorStatesCubit extends Cubit<DonorStatesViewState> {
  final DonorStatesUseCase donorStatesUseCase;

  DonorStatesCubit({required this.donorStatesUseCase})
    : super(DonorStatesInitialState());

  Future<void> fetchDonorStates() async {
    try {
      emit(DonorStatesLoadingState());

      final donorStateModel = await donorStatesUseCase.getDonorStates();

      if (donorStateModel.success == true && donorStateModel.data != null) {
        emit(DonorStatesSuccessState(donorStateModel: donorStateModel));
      } else {
        emit(
          DonorStatesErrorState(
            error: 'Failed to load donor states: Invalid response',
          ),
        );
      }
    } catch (e) {
      emit(DonorStatesErrorState(error: e.toString()));
    }
  }

  Future<void> retryFetchDonorStates() async {
    if (state is DonorStatesErrorState) {
      await fetchDonorStates();
    }
  }

  void reset() {
    emit(DonorStatesInitialState());
  }
}

sealed class DonorStatesViewState {}

class DonorStatesInitialState extends DonorStatesViewState {}

class DonorStatesLoadingState extends DonorStatesViewState {}

class DonorStatesSuccessState extends DonorStatesViewState {
  final DonorStateModel donorStateModel;

  DonorStatesSuccessState({required this.donorStateModel});

  int get totalDonations => donorStateModel.data?.totalDonations ?? 0;

  int get points => donorStateModel.data?.points ?? 0;

  int get livesSaved => donorStateModel.data?.livesSaved ?? 0;

  bool get hasDonations => totalDonations > 0;

  bool get hasPoints => points > 0;

  bool get hasSavedLives => livesSaved > 0;
}

class DonorStatesErrorState extends DonorStatesViewState {
  final String error;

  DonorStatesErrorState({required this.error});

  bool get isNetworkError =>
      error.toLowerCase().contains('network') ||
      error.toLowerCase().contains('timeout') ||
      error.toLowerCase().contains('connection');

  bool get isParseError =>
      error.toLowerCase().contains('parse') ||
      error.toLowerCase().contains('json');

  bool get isServerError =>
      error.toLowerCase().contains('server') || error.contains('HTTP');
}
