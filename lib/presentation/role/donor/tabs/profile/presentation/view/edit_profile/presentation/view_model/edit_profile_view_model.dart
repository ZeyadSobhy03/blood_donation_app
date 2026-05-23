import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/model/edit_profile_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase profileUseCase;

  EditProfileCubit({required this.profileUseCase})
      : super(EditProfileInitialState());

  Future<void> editProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String bloodType,
    required double weight,
    required String age,
    required String gender,
  }) async {
    emit(EditProfileLoadingState());
    try {
      final profile = await profileUseCase.editProfile(
        name: name,
        email: email,
        phone: phone,
        location: location,
        bloodType: bloodType,
        weight: weight,
        age: age,
        gender: gender,
      );
      emit(EditProfileSuccessState(profile));
    } on NetworkTimeoutException {
      emit(EditProfileErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(EditProfileErrorState(e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(EditProfileErrorState('unauthorized'));
    } on NotFoundException {
      emit(EditProfileErrorState('not_found'));
    } on RequestCancelledException {
      emit(EditProfileErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(EditProfileErrorState('unknown_error'));
    } catch (e) {
      emit(EditProfileErrorState('unknown_error'));
    }
  }
}

sealed class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {
  final EditProfileModel profile;
  EditProfileSuccessState(this.profile);
}

class EditProfileErrorState extends EditProfileState {
  final String message;
  EditProfileErrorState(this.message);
}