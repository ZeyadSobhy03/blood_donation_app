import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/donation_eligibility_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donation_eligibility/donation_eligibility_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';

class DonationEligibilityCubit extends Cubit<DonationEligibilityState> {
  final DonationEligibilityUseCase donationEligibilityUseCase;

  DonationEligibilityCubit(this.donationEligibilityUseCase)
      : super(DonationEligibilityInitial());

  Future<void> fetchDonationEligibility() async {
    emit(DonationEligibilityLoading());
    try {
      final donationEligibilityModel =
      await donationEligibilityUseCase.fetchDonationEligibility();
      emit(DonationEligibilitySuccess(donationEligibilityModel));
    } on NetworkTimeoutException {
      emit(DonationEligibilityFailure('network_timeout'));
    } on ServerException catch (e) {
      emit(DonationEligibilityFailure(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(DonationEligibilityFailure('unauthorized'));
    } on NotFoundException {
      emit(DonationEligibilityFailure('not_found'));
    } on RequestCancelledException {
      emit(DonationEligibilityFailure('request_cancelled'));
    } on UnknownNetworkException {
      emit(DonationEligibilityFailure('unknown_error'));
    } catch (e) {
      emit(DonationEligibilityFailure('unknown_error'));
    }
  }
}

sealed class DonationEligibilityState {}
class DonationEligibilityInitial extends DonationEligibilityState {}
class DonationEligibilityLoading extends DonationEligibilityState {}
class DonationEligibilitySuccess extends DonationEligibilityState {
  final DonationEligibilityModel donationEligibilityModel;
  DonationEligibilitySuccess(this.donationEligibilityModel);
}
class DonationEligibilityFailure extends DonationEligibilityState {
  final String errorMessage;
  DonationEligibilityFailure(this.errorMessage);
}