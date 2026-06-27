import 'dart:developer';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/admin_change_password/admin_change_password_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/admin_change_password/admin_change_password_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/log_out/admin_log_out_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../../core/utils/error_localizer.dart';

class AdminChangePasswordCubit extends Cubit<AdminChangePasswordState> {
  final AdminChangePasswordUseCase changePasswordUseCase;
  final AdminLogOutUseCase authUseCase;
  final AdminHiveDataSource authLocalDataSource;

  AdminChangePasswordCubit(
      this.changePasswordUseCase, {
        required this.authUseCase,
        required this.authLocalDataSource,
      }) : super(AdminChangePasswordInitialState());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      // Step 1: Change password on server
      final changePasswordModel = await changePasswordUseCase.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      // Step 2: Perform logout (don't let this affect success if password changed)
      try {
        await _performLogout();
      } catch (e) {
        // Log logout error but don't prevent success state
        log('Logout error after password change: $e');
        // Ensure local data is cleared
        await authLocalDataSource.clearAllData();
      }

      // Step 3: Emit success - password WAS successfully changed
      emit(ChangePasswordSuccessAndLoggedOutState(changePasswordModel));

    } on NetworkTimeoutException {
      log('Network timeout during password change');
      emit(ChangePasswordErrorState('network_timeout'));
    } on ServerException catch (e) {
      log('Server error during password change: ${e.serverMessage}');
      emit(ChangePasswordErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      log('Unauthorized error during password change');
      emit(ChangePasswordErrorState('unauthorized'));
    } catch (e) {
      log('Unknown error during password change: $e');
      emit(ChangePasswordErrorState('unknown_error'));
    }
  }

  Future<void> _performLogout() async {
    try {
      final refreshToken = await authLocalDataSource.getRefreshToken();
      String? fcmToken;

      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        log('Failed to get FCM token: $e');
        fcmToken = '';
      }

      if (refreshToken != null) {
        await authUseCase.logOut(
          refreshToken: refreshToken,
          fcmToken: fcmToken ?? '',
        );
      }
    } catch (e) {
      log('Error in logout process: $e');
      rethrow;
    } finally {
      // Always clear local data
      try {
        await authLocalDataSource.clearAllData();
      } catch (e) {
        log('Error clearing local data: $e');
      }
    }
  }
}

// ============ STATES ============

sealed class AdminChangePasswordState {}

class AdminChangePasswordInitialState extends AdminChangePasswordState {}

class ChangePasswordLoadingState extends AdminChangePasswordState {}

class ChangePasswordSuccessState extends AdminChangePasswordState {
  final AdminChangePasswordModel changePasswordModel;

  ChangePasswordSuccessState(this.changePasswordModel);
}

class ChangePasswordSuccessAndLoggedOutState extends AdminChangePasswordState {
  final AdminChangePasswordModel changePasswordModel;

  ChangePasswordSuccessAndLoggedOutState(this.changePasswordModel);
}

class ChangePasswordErrorState extends AdminChangePasswordState {
  final String errorMessage;

  ChangePasswordErrorState(this.errorMessage);
}