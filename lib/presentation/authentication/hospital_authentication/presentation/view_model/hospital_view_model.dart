import 'dart:developer';

import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/domain/use_case/hospital_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalUseCase hospitalUseCase;
  final HospitalLocalDataSource hospitalHiveDataSource;

  HospitalCubit({
    required this.hospitalUseCase,
    required this.hospitalHiveDataSource,
  }) : super(HospitalInitialState());


  Future<void> login({
    required String hospitalId,
    required String email,
    required String password,
  }) async {
    try {
      emit(HospitalLoadingState());

      final loginModel = await hospitalUseCase.login(
        hospitalId: hospitalId,
        email: email,
        password: password,
      );

      log('Hospital login response: success=${loginModel.success}, '
          'user=${loginModel.data?.userName}');

      if (loginModel.success == true && loginModel.data != null) {
        log('Saving hospital login data for: ${loginModel.data?.userName}');
        await hospitalHiveDataSource.saveLoginData(loginModel: loginModel);
        log('Hospital login data saved successfully.');
        emit(HospitalLoginSuccessState(loginModel: loginModel));
      } else {
        emit(HospitalErrorState(errorKey: 'UNKNOWN_ERROR'));
      }
    } catch (e) {
      emit(HospitalErrorState(errorKey: _parseError(e.toString())));
    }
  }


  Future<void> forgotPassword({required String email}) async {
    try {
      emit(HospitalLoadingState());
      await hospitalUseCase.forgotPassword(email: email);
      emit(HospitalForgotPasswordSuccessState());
    } catch (e) {
      emit(HospitalErrorState(errorKey: _parseError(e.toString())));
    }
  }


  Future<bool> isUserLoggedIn() async {
    try {
      return await hospitalHiveDataSource.isUserLoggedIn();
    } catch (_) {
      return false;
    }
  }

  Future<HospitalUser?> getSavedUserData() async {
    try {
      return await hospitalHiveDataSource.getUserData();
    } catch (_) {
      return null;
    }
  }

  Future<String?> getSavedAccessToken() async {
    try {
      return await hospitalHiveDataSource.getAccessToken();
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await hospitalHiveDataSource.clearAllData();
    } catch (_) {
    } finally {
      emit(HospitalInitialState());
    }
  }

  void reset() => emit(HospitalInitialState());

  String _parseError(String error) {
    final e = error.toLowerCase();

    if (e.contains('timeout') || e.contains('connection_timeout')) {
      return 'CONNECTION_TIMEOUT';
    } else if (e.contains('no_internet') || e.contains('connectionerror')) {
      return 'NO_INTERNET';
    } else if (e.contains('hospital_not_approved')) {
      return 'HOSPITAL_NOT_APPROVED';
    } else if (e.contains('bad_response')) {
      return 'BAD_RESPONSE';
    } else if (e.contains('empty_response')) {
      return 'EMPTY_RESPONSE';
    } else if (e.contains('server_error')) {
      return 'SERVER_ERROR';
    }

    return 'UNKNOWN_ERROR';
  }
}

sealed class HospitalState {}

class HospitalInitialState extends HospitalState {}

class HospitalLoadingState extends HospitalState {}

class HospitalLoginSuccessState extends HospitalState {
  final HospitalLoginModel loginModel;

  HospitalLoginSuccessState({required this.loginModel});

  String? get accessToken => loginModel.data?.accessToken;
  String? get refreshToken => loginModel.data?.refreshToken;
  HospitalUser? get user => loginModel.data?.user;
  String? get hospitalName => loginModel.data?.userName;
  bool get isLoginSuccess => loginModel.success == true;
}

class HospitalForgotPasswordSuccessState extends HospitalState {}

class HospitalErrorState extends HospitalState {
  final String errorKey;

  HospitalErrorState({required this.errorKey});

  bool get isNetworkError =>
      errorKey.contains('TIMEOUT') || errorKey.contains('NO_INTERNET');

  bool get isCredentialError => errorKey == 'BAD_RESPONSE';

  bool get isApprovalError => errorKey == 'HOSPITAL_NOT_APPROVED';

  bool get isServerError => errorKey == 'SERVER_ERROR';
}