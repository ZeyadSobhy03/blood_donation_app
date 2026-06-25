import 'dart:developer';

import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/data/models/hospital_profile_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/domain/use_cases/profile_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;
  final HospitalLocalDataSource hospitalLocalDataSource;
  AppLocalizations? _loc;

  ProfileCubit({
    required this.profileUseCase,
    required this.hospitalLocalDataSource,
  }) : super(ProfileInitialState());

  void setAppLoc(AppLocalizations loc) => _loc = loc;

  HospitalProfileData? _profile;

  HospitalProfileData? get profile => _profile;

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      final result = await profileUseCase.getProfile(token: token);
      if (isClosed) return;

      if (result.success == true && result.data != null) {
        _profile = result.data;
        emit(ProfileLoadedState(profile: result.data!));
      } else {
        emit(ProfileErrorState(
          message: result.message ?? _loc?.failedLoadProfile ?? 'Failed to load profile.',
        ));
      }
    } catch (e) {
      log('ProfileCubit.loadProfile error: $e');
      if (!isClosed) {
        emit(ProfileErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> updateProfile({
    required String hospitalName,
    required String department,
    required String contactNumber,
    required String email,
    required String address,
  }) async {
    try {
      emit(ProfileActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      await profileUseCase.updateProfile(
        token: token,
        hospitalName: hospitalName,
        department: department,
        contactNumber: contactNumber,
        email: email,
        address: address,
        lat: _profile?.location?.lat,
        lng: _profile?.location?.lng,
      );
      if (isClosed) return;

      emit(ProfileActionSuccessState(
        message: _loc?.profileUpdatedSuccess ?? 'Profile updated successfully',
      ));
      await loadProfile();
    } catch (e) {
      log('ProfileCubit.updateProfile error: $e');
      if (!isClosed) {
        emit(ProfileActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> updateWorkingHours({
    required int openingHour,
    required int closingHour,
    required int slotsPerHour,
  }) async {
    try {
      emit(ProfileActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      await profileUseCase.updateWorkingHours(
        token: token,
        workingHoursStart: openingHour,
        workingHoursEnd: closingHour,
        slotsPerHour: slotsPerHour,
      );
      if (isClosed) return;

      emit(ProfileActionSuccessState(
        message: _loc?.workingHoursUpdatedSuccess ?? 'Working hours updated successfully',
      ));
      await loadProfile();
    } catch (e) {
      log('ProfileCubit.updateWorkingHours error: $e');
      if (!isClosed) {
        emit(ProfileActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> updateNotificationPreferences({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool emailNotifications,
    required bool smsAlerts,
  }) async {
    try {
      emit(ProfileActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      await profileUseCase.updateNotificationPreferences(
        token: token,
        pushNotifications: pushNotifications,
        emergencyAlerts: emergencyAlerts,
        emailNotifications: emailNotifications,
        smsAlerts: smsAlerts,
      );
      if (isClosed) return;

      emit(ProfileActionSuccessState(
        message: 'Preferences saved',
      ));
      await loadProfile();
    } catch (e) {
      log('ProfileCubit.updateNotificationPreferences error: $e');
      if (!isClosed) {
        emit(ProfileActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(ProfileActionLoadingState());

      final token = await _getToken();
      if (isClosed) return;

      await profileUseCase.changePassword(
        token: token,
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      if (isClosed) return;

      emit(ProfileActionSuccessState(
        message: 'Password updated successfully',
      ));
    } catch (e) {
      log('ProfileCubit.changePassword error: $e');
      if (!isClosed) {
        emit(ProfileActionErrorState(message: _parseError(e.toString())));
      }
    }
  }

  Future<String> _getToken() async {
    final token = await hospitalLocalDataSource.getAccessToken();
    if (token == null || token.isEmpty) throw Exception('UNAUTHORIZED');
    return token;
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return _loc?.connectionTimedOut ?? 'Connection timed out. Please try again.';
    if (e.contains('no_internet') || e.contains('connectionerror')) {
      return _loc?.noInternetConnection ?? 'No internet connection.';
    }
    if (e.contains('unauthorized')) return _loc?.sessionExpired ?? 'Session expired. Please log in again.';
    if (e.contains('not_found')) return _loc?.profileNotFound ?? 'Profile not found.';
    if (e.contains('validation_error')) {
      return _loc?.checkAllFields ?? 'Please check all fields and try again.';
    }
    if (e.contains('unknown_error') || e.contains('bad_response')) {
      return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
    }
    if (e.contains('access_denied') || e.contains('forbidden')) {
      return _loc?.accessDenied ?? 'Access denied.';
    }
    if (e.contains('current_password_incorrect')) {
      return _loc?.currentPasswordIncorrect ?? 'Current password is incorrect.';
    }
    if (e.contains('password_must_be_different')) {
      return _loc?.passwordMustBeDifferent ?? 'New password must be different from current password.';
    }
    return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }
}

sealed class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final HospitalProfileData profile;
  ProfileLoadedState({required this.profile});
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}

class ProfileActionLoadingState extends ProfileState {}

class ProfileActionSuccessState extends ProfileState {
  final String message;
  ProfileActionSuccessState({required this.message});
}

class ProfileActionErrorState extends ProfileState {
  final String message;
  ProfileActionErrorState({required this.message});
}
