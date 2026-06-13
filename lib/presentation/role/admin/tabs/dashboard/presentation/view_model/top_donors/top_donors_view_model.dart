import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/top_donor/top_donor_model.dart';
import '../../../domain/use_case/top_donors/top_donors_use_case.dart';

class TopDonorsCubit extends Cubit<TopDonorsState> {
  final TopDonorsUseCase topDonorsUseCase;

  TopDonorsCubit({required this.topDonorsUseCase})
      : super(TopDonorsInitialState());

  Future<void> fetchTopDonors() async {
    emit(TopDonorsLoadingState());
    try {
      final topDonors = await topDonorsUseCase.getTopDonors();
      if (topDonors.success == true && topDonors.data != null) {
        emit(TopDonorsSuccessState(topDonors));
      } else {
        emit(TopDonorsErrorState('failed_to_load_top_donors'));
      }
    } on NetworkTimeoutException {
      emit(TopDonorsErrorState('network_timeout'));
    } on UnauthorizedException {
      emit(TopDonorsErrorState('unauthorized'));
    } on ServerException catch (e) {
      emit(TopDonorsErrorState(e.serverMessage ?? 'server_error'));
    } on NotFoundException {
      emit(TopDonorsErrorState('not_found'));
    } on RequestCancelledException {
      emit(TopDonorsErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(TopDonorsErrorState('unknown_error'));
    } catch (e) {
      emit(TopDonorsErrorState('unknown_error'));
    }
  }
}

sealed class TopDonorsState {}
class TopDonorsInitialState extends TopDonorsState {}
class TopDonorsLoadingState extends TopDonorsState {}
class TopDonorsSuccessState extends TopDonorsState {
  final TopDonorsModel topDonors;
  TopDonorsSuccessState(this.topDonors);
}
class TopDonorsErrorState extends TopDonorsState {
  final String errorMessage;
  TopDonorsErrorState(this.errorMessage);
}