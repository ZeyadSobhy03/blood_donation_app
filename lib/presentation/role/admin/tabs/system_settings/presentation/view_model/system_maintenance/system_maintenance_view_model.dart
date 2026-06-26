import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/system_maintenance/system_maintenance_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/system_maintenance/system_maintenance_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../data/model/system_maintenance/maintenance_status_model.dart';

class SystemMaintenanceCubit extends Cubit<SystemMaintenanceState> {
  final SystemMaintenanceUseCase systemMaintenanceUseCase;

  SystemMaintenanceCubit({
    required this.systemMaintenanceUseCase,
  }) : super(SystemMaintenanceInitialState());

  Future<void> toggleSystemMaintenance({
    required bool enabled,
    required String message,
  }) async {
    emit(SystemMaintenanceLoadingState());
    try {
      final systemMaintenanceModel = await systemMaintenanceUseCase.toggleSystemMaintenance(
        enabled: enabled,
        message: message,
      );
      emit(SystemMaintenanceSuccessState(systemMaintenanceModel));
    } on NetworkTimeoutException {
      emit(SystemMaintenanceErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(SystemMaintenanceErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(SystemMaintenanceErrorState('unauthorized'));
    } on NotFoundException {
      emit(SystemMaintenanceErrorState('not_found'));
    } on RequestCancelledException {
      emit(SystemMaintenanceErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(SystemMaintenanceErrorState('unknown_error'));
    } catch (e) {
      emit(SystemMaintenanceErrorState('unknown_error'));
    }
  }

  Future<void> getMaintenanceStatus() async {
    emit(SystemMaintenanceLoadingState());
    try {
      final maintenanceStatusModel = await systemMaintenanceUseCase.getMaintenanceStatus();
      emit(MaintenanceStatusSuccessState(maintenanceStatusModel));
    } on NetworkTimeoutException {
      emit(SystemMaintenanceErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(SystemMaintenanceErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(SystemMaintenanceErrorState('unauthorized'));
    } on NotFoundException {
      emit(SystemMaintenanceErrorState('not_found'));
    } on RequestCancelledException {
      emit(SystemMaintenanceErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(SystemMaintenanceErrorState('unknown_error'));
    } catch (e) {
      emit(SystemMaintenanceErrorState('unknown_error'));
    }
  }
}

sealed class SystemMaintenanceState {}

class SystemMaintenanceInitialState extends SystemMaintenanceState {}

class SystemMaintenanceLoadingState extends SystemMaintenanceState {}

class SystemMaintenanceSuccessState extends SystemMaintenanceState {
  final SystemMaintenanceModel systemMaintenanceModel;

  SystemMaintenanceSuccessState(this.systemMaintenanceModel);
}

class MaintenanceStatusSuccessState extends SystemMaintenanceState {
  final MaintenanceStatusModel maintenanceStatusModel;

  MaintenanceStatusSuccessState(this.maintenanceStatusModel);
}

class SystemMaintenanceErrorState extends SystemMaintenanceState {
  final String errorKey;

  SystemMaintenanceErrorState(this.errorKey);
}