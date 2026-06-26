import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/admin_change_password/admin_change_password_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/admin_change_password/admin_change_password_use_case.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/errors/app_exceptions.dart';
import '../../../../../../../../core/utils/error_localizer.dart';

class AdminChangePasswordCubit extends Cubit<AdminChangePasswordState> {
  final AdminChangePasswordUseCase changePasswordUseCase;
  final AuthUseCase authUseCase;
  final AdminHiveDataSource authLocalDataSource;

  AdminChangePasswordCubit(
    this.changePasswordUseCase, {
    required this.authUseCase,
    required this.authLocalDataSource,
  }) : super(AdminChangePasswordInitialState());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      final changePasswordModel = await changePasswordUseCase.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      // Logout after successful password change
      await _performLogout();

      emit(ChangePasswordSuccessAndLoggedOutState(changePasswordModel));
    } on NetworkTimeoutException {
      emit(ChangePasswordErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(ChangePasswordErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(ChangePasswordErrorState('unauthorized'));
    } catch (e) {
      emit(ChangePasswordErrorState('unknown_error'));
    }
  }

  Future<void> _performLogout() async {
    try {
      final refreshToken = await authLocalDataSource.getRefreshToken();
      String? fcmToken;

      try {
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (_) {
        fcmToken = '';
      }

      if (refreshToken != null) {
        await authUseCase.logOut(
          refreshToken: refreshToken,
          fcmToken: fcmToken ?? '',
        );
      }
    } catch (_) {
    } finally {
      await authLocalDataSource.clearAllData();
    }
  }
}

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
