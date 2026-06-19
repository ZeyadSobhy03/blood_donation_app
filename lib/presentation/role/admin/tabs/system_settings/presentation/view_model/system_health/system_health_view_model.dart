import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/errors/app_exceptions.dart';
import '../../../data/model/system_health/system_health_model.dart';
import '../../../domain/use_case/system_health/system_health_use_case.dart';

class SystemHealthCubit extends Cubit<SystemHealthState> {
  final SystemHealthUseCase systemHealthUseCase;

  SystemHealthCubit({
    required this.systemHealthUseCase,
  }) : super(SystemHealthInitialState());

  Future<void> fetchSystemHealth() async {
    emit(SystemHealthLoadingState());
    try {
      final systemHealthModel = await systemHealthUseCase.getSystemHealth();
      emit(SystemHealthSuccessState(systemHealthModel: systemHealthModel));
    } on NetworkTimeoutException {
      emit(SystemHealthErrorState(errorKey: 'network_timeout'));
    } on ServerException catch (e) {
      emit(SystemHealthErrorState(errorKey: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(SystemHealthErrorState(errorKey: 'unauthorized'));
    } on NotFoundException {
      emit(SystemHealthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(SystemHealthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(SystemHealthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(SystemHealthErrorState(errorKey: 'unknown_error'));
    }
  }
}


sealed class SystemHealthState {}

class SystemHealthInitialState extends SystemHealthState {}

class SystemHealthLoadingState extends SystemHealthState {}

class SystemHealthSuccessState extends SystemHealthState {
  final SystemHealthModel systemHealthModel;
  SystemHealthSuccessState({required this.systemHealthModel});
}

class SystemHealthErrorState extends SystemHealthState {
  final String errorKey;
  SystemHealthErrorState({required this.errorKey});
}