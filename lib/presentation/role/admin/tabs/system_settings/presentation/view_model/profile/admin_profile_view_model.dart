import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/profile/admin_profile_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/profile/admin_profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/errors/app_exceptions.dart';

class AdminProfileCubit extends Cubit<ProfileState> {
  final AdminProfileUseCase adminProfileUseCase;

  AdminProfileCubit({
    required this.adminProfileUseCase,
  }) : super(ProfileInitialState());

  Future<void> fetchAdminProfile() async {
    emit(ProfileLoadingState());
    try {
      final profile = await adminProfileUseCase.getProfile();
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
}

sealed class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final AdminProfileModel profile;
  ProfileSuccessState({required this.profile});
}

class ProfileErrorState extends ProfileState {
  final String errorKey;
  ProfileErrorState({required this.errorKey});
}