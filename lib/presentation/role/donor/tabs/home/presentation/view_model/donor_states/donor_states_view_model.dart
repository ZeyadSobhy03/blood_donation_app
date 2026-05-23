
import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donor_states/donor_state_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/donor_states/donor_states_use_case.dart';

class DonorStatesCubit extends Cubit<DonorStatesViewState> {
  final DonorStatesUseCase donorStatesUseCase;

  DonorStatesCubit({required this.donorStatesUseCase})
      : super(DonorStatesInitialState());

  Future<void> fetchDonorStates() async {
    emit(DonorStatesLoadingState());
    try {
      final donorStateModel = await donorStatesUseCase.getDonorStates();
      emit(DonorStatesSuccessState(donorStateModel: donorStateModel));
    } on NetworkTimeoutException {
      emit(DonorStatesErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      emit(DonorStatesErrorState(error: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(DonorStatesErrorState(error: 'unauthorized'));
    } on NotFoundException {
      emit(DonorStatesErrorState(error: 'not_found'));
    } on RequestCancelledException {
      emit(DonorStatesErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(DonorStatesErrorState(error: 'unknown_error'));
    } catch (e) {
      emit(DonorStatesErrorState(error: 'unknown_error'));
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
      error == 'network_timeout' || error == 'unknown_error';

  bool get isServerError =>
      error == 'server_error' || error == 'unauthorized' || error == 'not_found';

  bool get isNotFound => error == 'not_found';

  bool get isUnauthorized => error == 'unauthorized';
}