import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/profile_use_case.dart';

class ProfileCubit extends Cubit<ProfileViewState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit({required this.profileUseCase}) : super(ProfileInitialState());

  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoadingState());

      final profileModel = await profileUseCase.getProfile();

      if (profileModel.success == true && profileModel.data != null) {
        emit(ProfileSuccessState(profileModel: profileModel));
      } else {
        emit(
          ProfileErrorState(
            error: 'Failed to load profile: Invalid response',
          ),
        );
      }
    } catch (e) {
      emit(ProfileErrorState(error: e.toString()));
    }
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

class ProfileLoadingState extends ProfileViewState {
}
class ProfileSuccessState extends ProfileViewState {
  final ProfileModel profileModel;

  ProfileSuccessState({required this.profileModel});
}
class ProfileErrorState extends ProfileViewState {
  final String error;

  ProfileErrorState({required this.error});
}
