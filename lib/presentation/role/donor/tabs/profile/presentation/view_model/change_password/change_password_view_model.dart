import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/change_password/change_password_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../authentication/donor_authentication/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../../../../../../authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import '../../../domain/use_case/change_password/change_password_use_case.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;
  final AuthUseCase authUseCase;
  final AuthLocalDataSource authLocalDataSource;

  ChangePasswordCubit(
      this.changePasswordUseCase, {
        required this.authUseCase,
        required this.authLocalDataSource,
      }) : super(ChangePasswordInitialState());

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

sealed class ChangePasswordState {}
class ChangePasswordInitialState extends ChangePasswordState {}
class ChangePasswordLoadingState extends ChangePasswordState {}
class ChangePasswordSuccessState extends ChangePasswordState {
  final ChangePasswordModel changePasswordModel;
  ChangePasswordSuccessState(this.changePasswordModel);
}
// New state that signals logout happened
class ChangePasswordSuccessAndLoggedOutState extends ChangePasswordState {
  final ChangePasswordModel changePasswordModel;
  ChangePasswordSuccessAndLoggedOutState(this.changePasswordModel);
}
class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;
  ChangePasswordErrorState(this.errorMessage);
}