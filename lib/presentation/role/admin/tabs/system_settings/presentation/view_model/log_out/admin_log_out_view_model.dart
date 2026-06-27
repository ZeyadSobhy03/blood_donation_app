import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/log_out_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/log_out/admin_log_out_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';


class AdminLogOutViewModel extends Cubit<AdminLogOutState> {
  final AdminLogOutUseCase logOutUseCase;

  AdminLogOutViewModel(this.logOutUseCase) : super(AdminLogOutInitialState());

  Future<void> logOut({
    required String refreshToken,
    required String fcmToken,
  }) async {
    emit(AdminLogOutLoadingState());
    try {
      final logOutModel = await logOutUseCase.logOut(
        refreshToken: refreshToken,
        fcmToken: fcmToken,
      );
      emit(AdminLogOutSuccessState(logOutModel));
    } on NetworkTimeoutException {
      emit(AdminLogOutErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AdminLogOutErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(AdminLogOutErrorState('unauthorized'));
    } catch (e) {
      emit(AdminLogOutErrorState('unknown_error'));
    }
  }
}

sealed class AdminLogOutState {}

class AdminLogOutInitialState extends AdminLogOutState {}

class AdminLogOutLoadingState extends AdminLogOutState {}

class AdminLogOutSuccessState extends AdminLogOutState {
  final LogOutModel logOutModel;
  AdminLogOutSuccessState(this.logOutModel);
}

class AdminLogOutErrorState extends AdminLogOutState {
  final String errorMessage;
  AdminLogOutErrorState(this.errorMessage);
}