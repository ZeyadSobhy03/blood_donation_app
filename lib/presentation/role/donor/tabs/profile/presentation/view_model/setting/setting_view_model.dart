import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/setting/setting_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/setting/setting_model.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingUseCase settingUseCase;

  SettingCubit({required this.settingUseCase}) : super(SettingInitialState());

  Future<void> getSetting() async {
    emit(SettingLoadingState());
    try {
      final settingModel = await settingUseCase.getSetting();
      emit(SettingSuccessState(settingModel: settingModel));
    } on NetworkTimeoutException {
      emit(SettingErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      emit(SettingErrorState(error: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(SettingErrorState(error: 'unauthorized'));
    } on NotFoundException {
      emit(SettingErrorState(error: 'not_found'));
    } on RequestCancelledException {
      emit(SettingErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(SettingErrorState(error: 'unknown_error'));
    } catch (e) {
      emit(SettingErrorState(error: 'unknown_error'));
    }
  }

  Future<void> updateSetting({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool privacyMode,
    required String language,
  }) async {
    emit(SettingLoadingState());
    try {
      final settingModel = await settingUseCase.updateSetting(
        pushNotifications: pushNotifications,
        emergencyAlerts: emergencyAlerts,
        privacyMode: privacyMode,
        language: language,
      );
      emit(SettingSuccessState(settingModel: settingModel));
    } on NetworkTimeoutException {
      emit(SettingErrorState(error: 'network_timeout'));
    } on ServerException catch (e) {
      emit(SettingErrorState(error: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(SettingErrorState(error: 'unauthorized'));
    } on NotFoundException {
      emit(SettingErrorState(error: 'not_found'));
    } on RequestCancelledException {
      emit(SettingErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(SettingErrorState(error: 'unknown_error'));
    } catch (e) {
      emit(SettingErrorState(error: 'unknown_error'));
    }
  }
}

sealed class SettingState {}

class SettingInitialState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingSuccessState extends SettingState {
  final SettingModel settingModel;

  SettingSuccessState({required this.settingModel});
}

class SettingErrorState extends SettingState {
  final String error;

  SettingErrorState({required this.error});
}