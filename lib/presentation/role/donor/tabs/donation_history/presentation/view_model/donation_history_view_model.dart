import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/model/donation_history_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/domain/use_case/donation_history_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationHistoryCubit extends Cubit<DonationHistoryState> {
  final DonationHistoryUseCase donationHistoryUseCase;

  DonationHistoryCubit(this.donationHistoryUseCase)
    : super(DonationHistoryInitial());

  Future<void> getDonationHistory({int page = 1, int limit = 10}) async {
    emit(DonationHistoryLoading());
    try {
      final donationHistory = await donationHistoryUseCase.fetchDonationHistory(
        page: page,
        limit: limit,
      );
      emit(DonationHistoryLoaded(donationHistory));
    } on NetworkTimeoutException {
      emit(DonationHistoryError('network_timeout'));
    } on ServerException catch (e) {
      emit(DonationHistoryError(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(DonationHistoryError('unauthorized'));
    } on NotFoundException {
      emit(DonationHistoryError('not_found'));
    } on RequestCancelledException {
      emit(DonationHistoryError('request_cancelled'));
    } on UnknownNetworkException {
      emit(DonationHistoryError('unknown_error'));
    } catch (e) {
      emit(DonationHistoryError('unknown_error'));
    }
  }
}

sealed class DonationHistoryState {}

class DonationHistoryInitial extends DonationHistoryState {}

class DonationHistoryLoading extends DonationHistoryState {}

class DonationHistoryLoaded extends DonationHistoryState {
  final DonationHistoryModel donationHistory;

  DonationHistoryLoaded(this.donationHistory);
}

class DonationHistoryError extends DonationHistoryState {
  final String message;

  DonationHistoryError(this.message);
}
