import 'dart:developer';

import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/profile/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../domain/use_case/profile/profile_use_case.dart';

class ProfileCubit extends Cubit<ProfileViewState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit({required this.profileUseCase}) : super(ProfileInitialState());

  Future<void> fetchProfile() async {
    emit(ProfileLoadingState());
    try {
      final profileModel = await profileUseCase.getProfile();
      emit(ProfileSuccessState(profileModel: profileModel));
    } on NetworkTimeoutException {
      emit(ProfileErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      log('Error fetching profile: ${e.serverMessage}');
      emit(ProfileErrorState(error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(ProfileErrorState(error: 'unauthorized'));
    } on NotFoundException {
      emit(ProfileErrorState(error: 'not_found'));
    } on RequestCancelledException {
      emit(ProfileErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(ProfileErrorState(error: 'unknown_error'));
    } catch (e) {
      log('Unknown error while fetching profile: $e');
      emit(ProfileErrorState(error: 'unknown_error'));
    }
  }

  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  Future<void> retryFetchProfile() async {
    if (state is ProfileErrorState) {
      await fetchProfile();
    }
  }

  void reset() {
    emit(ProfileInitialState());
  }
}

sealed class ProfileViewState {}

class ProfileInitialState extends ProfileViewState {}

class ProfileLoadingState extends ProfileViewState {}

class ProfileSuccessState extends ProfileViewState {
  final ProfileModel profileModel;

  ProfileSuccessState({required this.profileModel});
}

class ProfileErrorState extends ProfileViewState {
  final String error;

  ProfileErrorState({required this.error});
}