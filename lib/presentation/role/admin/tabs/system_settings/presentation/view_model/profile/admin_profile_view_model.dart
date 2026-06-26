import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_update_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/profile/admin_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/errors/app_exceptions.dart';

class AdminProfileCubit extends Cubit<ProfileState> {
  final AdminProfileUseCase adminProfileUseCase;

  AdminProfileCubit({
    required this.adminProfileUseCase,
  }) : super(ProfileInitialState());

  AdminProfileModel? _currentProfile;
  AdminProfileModel? get currentProfile => _currentProfile;

  Future<void> fetchAdminProfile() async {
    emit(ProfileLoadingState());
    try {
      final profile = await adminProfileUseCase.getProfile();
      _currentProfile = profile;
      emit(ProfileSuccessState(profile: profile));
    } on NetworkTimeoutException {
      emit(ProfileErrorState(errorKey: 'network_timeout'));
    } on ServerException catch (e) {
      emit(ProfileErrorState(errorKey: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(ProfileErrorState(errorKey: 'unauthorized'));
    } on NotFoundException {
      emit(ProfileErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(ProfileErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(ProfileErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(ProfileErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> updateAdminProfile({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    emit(ProfileUpdateLoadingState());
    try {
      final updatedProfile = await adminProfileUseCase.updateProfile(
        fullName: fullName,
        email: email,
        phone: phone,
      );
      _currentProfile = _currentProfile?.copyWith(
        data: _currentProfile?.data?.copyWith(
          admin: _currentProfile?.data?.admin?.copyWith(
            fullName: fullName,
            email: email,
            phone: phone,
          ),
        ),
      );
      emit(ProfileUpdateSuccessState(updatedProfile: updatedProfile));
    } on NetworkTimeoutException {
      emit(ProfileErrorState(errorKey: 'network_timeout'));
    } on ServerException catch (e) {
      emit(ProfileErrorState(errorKey: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(ProfileErrorState(errorKey: 'unauthorized'));
    } on NotFoundException {
      emit(ProfileErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(ProfileErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(ProfileErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(ProfileErrorState(errorKey: 'unknown_error'));
    }
  }
}

sealed class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileUpdateLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final AdminProfileModel profile;
  ProfileSuccessState({required this.profile});
}

class ProfileUpdateSuccessState extends ProfileState {
  final AdminProfileUpdateModel updatedProfile;
  ProfileUpdateSuccessState({required this.updatedProfile});
}

class ProfileErrorState extends ProfileState {
  final String errorKey;
  ProfileErrorState({required this.errorKey});
}