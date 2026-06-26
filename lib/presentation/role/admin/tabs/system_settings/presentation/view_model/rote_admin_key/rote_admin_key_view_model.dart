import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/model/rote_admin_key/rote_admin_key_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/rote_admin_key/rote_admin_key_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';

class RoteAdminKeyCubit extends Cubit<RoteAdminKeyState> {
  final RoteAdminKeyUseCase roteAdminKeyUseCase;

  RoteAdminKeyCubit({
    required this.roteAdminKeyUseCase,
  }) : super(RoteAdminKeyInitialState());

  Future<void> roteAdminKey({required String id}) async {
    emit(RoteAdminKeyLoadingState());

    try {
      final responseModel = await roteAdminKeyUseCase.roteAdminKey(id: id);
      emit(RoteAdminKeySuccessState(responseModel));

    } on NetworkTimeoutException {
      emit(RoteAdminKeyErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(RoteAdminKeyErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(RoteAdminKeyErrorState('unauthorized'));
    } on NotFoundException {
      emit(RoteAdminKeyErrorState('not_found'));
    } on RequestCancelledException {
      emit(RoteAdminKeyErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(RoteAdminKeyErrorState('unknown_error'));
    } catch (e) {
      emit(RoteAdminKeyErrorState('unknown_error'));
    }
  }
}


sealed class RoteAdminKeyState {}

class RoteAdminKeyInitialState extends RoteAdminKeyState {}

class RoteAdminKeyLoadingState extends RoteAdminKeyState {}

class RoteAdminKeySuccessState extends RoteAdminKeyState {
  final RoteAdminKeyModel roteAdminKeyModel;
  RoteAdminKeySuccessState(this.roteAdminKeyModel);
}

class RoteAdminKeyErrorState extends RoteAdminKeyState {
  final String message;
  RoteAdminKeyErrorState(this.message);
}