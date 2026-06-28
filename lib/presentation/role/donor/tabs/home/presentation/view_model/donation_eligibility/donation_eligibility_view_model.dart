import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/donation_eligibility_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/donation_eligibility/participation_preference_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donation_eligibility/donation_eligibility_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../../core/utils/error_localizer.dart';

class DonationEligibilityCubit extends Cubit<DonationEligibilityState> {
  final DonationEligibilityUseCase donationEligibilityUseCase;

  bool _currentParticipation = false;
  bool get currentParticipation => _currentParticipation;

  DonationEligibilityCubit(this.donationEligibilityUseCase)
    : super(DonationEligibilityInitial());

  Future<void> fetchDonationEligibility() async {
    emit(DonationEligibilityLoading());
    try {
      final donationEligibilityModel = await donationEligibilityUseCase
          .fetchDonationEligibility();
      _currentParticipation =
          donationEligibilityModel.data?.participationEnabled ?? false;
      emit(DonationEligibilitySuccess(donationEligibilityModel));
    } on NetworkTimeoutException {
      emit(DonationEligibilityFailure('network_timeout'));
    } on ServerException catch (e) {
      emit(DonationEligibilityFailure(mapServerErrorToKey(e.serverMessage)));
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

  Future<void> setParticipation({required bool participation}) async {
    final currentState = state;
    DonationEligibilityModel? previousModel;
    if (currentState is DonationEligibilitySuccess) {
      previousModel = currentState.donationEligibilityModel;
    } else if (currentState is DonationEligibilityParticipationSuccess) {
      previousModel = currentState.donationEligibilityModel;
    }

    try {
      final result = await donationEligibilityUseCase.setParticipation(
        participation: participation,
      );

      if (result.success == true) {
        _currentParticipation = result.data?.isOptedIn ?? participation;

        final updatedModel = previousModel?.copyWith(
          data: previousModel.data?.copyWith(
            participationEnabled: _currentParticipation,
          ),
        );

        emit(
          DonationEligibilityParticipationSuccess(
            participationPreferenceModel: result,
            donationEligibilityModel: updatedModel,
          ),
        );
      } else {
        emit(DonationEligibilityFailure('participation_update_failed'));
      }
    } on NetworkTimeoutException {
      emit(DonationEligibilityFailure('network_timeout'));
      _currentParticipation = !participation;
    } on ServerException catch (e) {
      emit(DonationEligibilityFailure(mapServerErrorToKey(e.serverMessage)));
      _currentParticipation = !participation;
    } on UnauthorizedException {
      emit(DonationEligibilityFailure('unauthorized'));
      _currentParticipation = !participation;
    } on NotFoundException {
      emit(DonationEligibilityFailure('not_found'));
      _currentParticipation = !participation;
    } on RequestCancelledException {
      emit(DonationEligibilityFailure('request_cancelled'));
      _currentParticipation = !participation;
    } on UnknownNetworkException {
      emit(DonationEligibilityFailure('unknown_error'));
      _currentParticipation = !participation;
    } catch (e) {
      emit(DonationEligibilityFailure('unknown_error'));
      _currentParticipation = !participation;
    }
  }
}

sealed class DonationEligibilityState {}

class DonationEligibilityInitial extends DonationEligibilityState {}

class DonationEligibilityLoading extends DonationEligibilityState {}

class DonationEligibilityParticipationLoading extends DonationEligibilityState {
  final DonationEligibilityModel? donationEligibilityModel;

  DonationEligibilityParticipationLoading({
    required this.donationEligibilityModel,
  });
}

class DonationEligibilitySuccess extends DonationEligibilityState {
  final DonationEligibilityModel donationEligibilityModel;

  DonationEligibilitySuccess(this.donationEligibilityModel);
}

class DonationEligibilityParticipationSuccess extends DonationEligibilityState {
  final ParticipationPreferenceModel participationPreferenceModel;
  final DonationEligibilityModel? donationEligibilityModel;

  DonationEligibilityParticipationSuccess({
    required this.participationPreferenceModel,
    this.donationEligibilityModel,
  });
}

class DonationEligibilityFailure extends DonationEligibilityState {
  final String errorMessage;

  DonationEligibilityFailure(this.errorMessage);
}
