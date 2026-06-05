import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/model/edit_profile_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase profileUseCase;

  EditProfileCubit({required this.profileUseCase})
      : super(EditProfileInitialState());

  Future<void> editProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String gender,
    required int weight,
    required String bloodType,
    required String dateOfBirth,
    required String city,
    required String governorate,
    required double lat,
    required double lng,
  }) async {
    emit(EditProfileLoadingState());
    try {
      final profile = await profileUseCase.editProfile(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        weight: weight,
        bloodType: bloodType,
        dateOfBirth: dateOfBirth,
        city: city,
        governorate: governorate,
        lat: lat,
        lng: lng,
      );
      emit(EditProfileSuccessState(profile));
    } on NetworkTimeoutException {
      emit(EditProfileErrorState('network_timeout'));
    } on ServerException catch (e) {
      final key = mapServerErrorToKey(e.serverMessage);
      emit(EditProfileErrorState(key));
    } on UnauthorizedException {
      emit(EditProfileErrorState('unauthorized'));
    } on NotFoundException {
      emit(EditProfileErrorState('not_found'));
    } on RequestCancelledException {
      emit(EditProfileErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(EditProfileErrorState('unknown_error'));
    } catch (_) {
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