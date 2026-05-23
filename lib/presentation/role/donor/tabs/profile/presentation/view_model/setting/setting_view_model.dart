import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/setting/setting_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/setting/setting_model.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingUseCase settingUseCase;

  SettingCubit({required this.settingUseCase}) : super(SettingInitialState());

  Future<void> getSetting() async {
    try {
      emit(SettingLoadingState());
      final settingModel = await settingUseCase.getSetting();
      if (settingModel.success == true && settingModel.data != null) {
        emit(SettingSuccessState(settingModel: settingModel));
      } else {
        emit(
          SettingErrorState(error: 'Failed to load setting: Invalid response'),
        );
      }
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
    }
  }

  Future<void> updateSetting({
    required bool pushNotifications,
    required bool emergencyAlerts,
    required bool privacyMode,
    required String language,
  }) async {
    try {
      emit(SettingLoadingState());
      final settingModel = await settingUseCase.updateSetting(
        pushNotifications: pushNotifications,
        emergencyAlerts: emergencyAlerts,
        privacyMode: privacyMode,
        language: language,
      );

      if (settingModel.success == true && settingModel.data != null) {
        emit(SettingSuccessState(settingModel: settingModel));
      } else {
        emit(
          SettingErrorState(
            error: 'Failed to update setting: Invalid response',
          ),
        );
      }
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
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
