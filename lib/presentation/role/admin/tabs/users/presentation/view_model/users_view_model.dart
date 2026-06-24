import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/resources/models/create_hospital_model.dart';
import '../../data/model/admin_model.dart';
import '../../domain/use_case/users_use_case.dart';

class ActionResult {
  final bool success;
  final String? errorMessage;
  final Admin? admin;

  const ActionResult.success()
      : success = true,
        errorMessage = null,
        admin = null;

  const ActionResult.successWithAdmin(this.admin)
      : success = true,
        errorMessage = null;

  const ActionResult.failure(this.errorMessage)
      : success = false,
        admin = null;
}

class UsersCubit extends Cubit<UsersState> {
  final UsersUseCase usersUseCase;

  UsersCubit({required this.usersUseCase}) : super(UsersInitialState());

  final int _limit = 10;
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;
  bool _isDeleting = false;
  bool _isProcessingBan = false;
  bool _isCreatingHospital = false;
  bool _isCreatingAdmin = false;
  bool _isUpdatingDonor = false;
  bool _isUpdatingHospital = false;
  bool _isUpdatingAdmin = false;
  final List<Users> _allUsers = [];

  String? _role;
  String? _search;

  bool get hasNextPage => _hasNextPage;

  Future<void> getUsers({String? role, String? search}) async {
    _currentPage = 1;
    _allUsers.clear();
    _role = role;
    _search = search;

    emit(UsersLoadingState());
    try {
      final usersModel = await usersUseCase.getUsers(
        page: _currentPage,
        limit: _limit,
        role: _role,
        search: _search,
      );
      if (usersModel.success == true && usersModel.data != null) {
        _allUsers.addAll(usersModel.data?.users ?? []);
        _hasNextPage = usersModel.data?.pagination?.hasNextPage ?? false;
        emit(UsersSuccessState(
          usersModel: usersModel,
          users: List.of(_allUsers),
          hasNextPage: _hasNextPage,
        ));
      } else {
        emit(UsersErrorState(errorMessage: 'failed_to_load_users'));
      }
    } on NetworkTimeoutException {
      emit(UsersErrorState(errorMessage: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(UsersErrorState(errorMessage: e.message ?? 'unauthorized'));
    } on ServerException catch (e) {
      emit(UsersErrorState(errorMessage: e.serverMessage ?? 'server_error'));
    } on NotFoundException {
      emit(UsersErrorState(errorMessage: 'not_found'));
    } on RequestCancelledException {
      emit(UsersErrorState(errorMessage: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(UsersErrorState(errorMessage: 'unknown_error'));
    } catch (e) {
      emit(UsersErrorState(errorMessage: 'unknown_error'));
    }
  }

  Future<void> loadMoreUsers() async {
    if (_isLoadingMore || !_hasNextPage) return;

    final currentState = state;
    if (currentState is! UsersSuccessState) return;

    _isLoadingMore = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: true,
    ));

    try {
      final nextPage = _currentPage + 1;
      final usersModel = await usersUseCase.getUsers(
        page: nextPage,
        limit: _limit,
        role: _role,
        search: _search,
      );

      if (usersModel.success == true && usersModel.data != null) {
        _currentPage = nextPage;
        _allUsers.addAll(usersModel.data?.users ?? []);
        _hasNextPage = usersModel.data?.pagination?.hasNextPage ?? false;
        emit(UsersSuccessState(
          usersModel: usersModel,
          users: List.of(_allUsers),
          hasNextPage: _hasNextPage,
          isLoadingMore: false,
        ));
      } else {
        emit(UsersSuccessState(
          usersModel: currentState.usersModel,
          users: List.of(_allUsers),
          hasNextPage: _hasNextPage,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      emit(UsersSuccessState(
        usersModel: currentState.usersModel,
        users: List.of(_allUsers),
        hasNextPage: _hasNextPage,
        isLoadingMore: false,
      ));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<ActionResult> deleteUser({required String userId}) async {
    if (_isDeleting) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isDeleting = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final deleteUserModel = await usersUseCase.deleteUser(userId: userId);
      if (deleteUserModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(deleteUserModel.message ?? 'failed_to_delete_user');
        _emitDeleteError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitDeleteError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitDeleteError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitDeleteError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitDeleteError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitDeleteError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitDeleteError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitDeleteError(currentState, result.errorMessage!);
    } finally {
      _isDeleting = false;
    }

    return result;
  }

  Future<ActionResult> banUser({required String userId, required String reason}) async {
    if (_isProcessingBan) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isProcessingBan = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final banUserModel = await usersUseCase.banUser(userId: userId, reason: reason);
      if (banUserModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(banUserModel.message ?? 'failed_to_ban_user');
        _emitBanError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitBanError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitBanError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitBanError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitBanError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitBanError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitBanError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitBanError(currentState, result.errorMessage!);
    } finally {
      _isProcessingBan = false;
    }

    return result;
  }

  Future<ActionResult> unbanUser({required String userId}) async {
    if (_isProcessingBan) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isProcessingBan = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final unbanUserModel = await usersUseCase.unbanUser(userId: userId);
      if (unbanUserModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(unbanUserModel.message ?? 'failed_to_unban_user');
        _emitBanError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitBanError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitBanError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitBanError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitBanError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitBanError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitBanError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitBanError(currentState, result.errorMessage!);
    } finally {
      _isProcessingBan = false;
    }

    return result;
  }

  Future<ActionResult> createHospital({required CreateHospitalModel createHospitalModel}) async {
    if (_isCreatingHospital) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isCreatingHospital = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final hospitalModel = await usersUseCase.createHospital(createHospitalModel: createHospitalModel);
      if (hospitalModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(hospitalModel.message ?? 'failed_to_create_hospital');
        _emitCreateHospitalError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitCreateHospitalError(currentState, result.errorMessage!);
    } finally {
      _isCreatingHospital = false;
    }

    return result;
  }

  Future<ActionResult> createAdmin({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) async {
    if (_isCreatingAdmin) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isCreatingAdmin = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final adminModel = await usersUseCase.createAdmin(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
        role: role,
      );
      if (adminModel.success == true && adminModel.data?.admin != null) {
        result = ActionResult.successWithAdmin(adminModel.data!.admin!);
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(adminModel.message ?? 'failed_to_create_admin');
        _emitCreateAdminError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitCreateAdminError(currentState, result.errorMessage!);
    } finally {
      _isCreatingAdmin = false;
    }

    return result;
  }

  Future<ActionResult> updateDonor({
    required String fullName,
    required String phoneNumber,
    required String bloodType,
    required String userId,
  }) async {
    if (_isUpdatingDonor) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isUpdatingDonor = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final updateDonorModel = await usersUseCase.updateDonor(
        fullName: fullName,
        phoneNumber: phoneNumber,
        bloodType: bloodType,
        userId: userId,
      );
      if (updateDonorModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(updateDonorModel.message ?? 'failed_to_update_donor');
        _emitUpdateDonorError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateDonorError(currentState, result.errorMessage!);
    } finally {
      _isUpdatingDonor = false;
    }

    return result;
  }

  Future<ActionResult> updateHospital({
    required String fullName,
    required String hospitalName,
    required String phone,
    required List<String> bloodBanksAvailable,
    required int capacity,
    required String userId,
  }) async {
    if (_isUpdatingHospital) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isUpdatingHospital = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: currentState.isUpdatingDonor,
      isUpdatingHospital: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final updateHospitalModel = await usersUseCase.updateHospital(
        fullName: fullName,
        hospitalName: hospitalName,
        phone: phone,
        bloodBanksAvailable: bloodBanksAvailable,
        capacity: capacity,
        userId: userId,
      );
      if (updateHospitalModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(updateHospitalModel.message ?? 'failed_to_update_hospital');
        _emitUpdateHospitalError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateHospitalError(currentState, result.errorMessage!);
    } finally {
      _isUpdatingHospital = false;
    }

    return result;
  }

  Future<ActionResult> updateAdmin({
    required String fullName,
    required bool isSuspended,
    required String userId,
  }) async {
    if (_isUpdatingAdmin) {
      return const ActionResult.failure('action_in_progress');
    }

    final currentState = state;
    if (currentState is! UsersSuccessState) {
      return const ActionResult.failure('unknown_error');
    }

    _isUpdatingAdmin = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: currentState.isDeleting,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: currentState.isUpdatingDonor,
      isUpdatingHospital: currentState.isUpdatingHospital,
      isUpdatingAdmin: true,
    ));

    ActionResult result = const ActionResult.failure('unknown_error');
    try {
      final updateAdminModel = await usersUseCase.updateAdmin(
        fullName: fullName,
        isSuspended: isSuspended,
        userId: userId,
      );
      if (updateAdminModel.success == true) {
        result = const ActionResult.success();
        await getUsers(role: _role, search: _search);
      } else {
        result = ActionResult.failure(updateAdminModel.message ?? 'failed_to_update_admin');
        _emitUpdateAdminError(currentState, result.errorMessage!);
      }
    } on NetworkTimeoutException {
      result = const ActionResult.failure('network_timeout');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } on UnauthorizedException catch (e) {
      result = ActionResult.failure(e.message ?? 'unauthorized');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } on ServerException catch (e) {
      result = ActionResult.failure(e.serverMessage ?? 'server_error');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } on NotFoundException {
      result = const ActionResult.failure('not_found');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } on RequestCancelledException {
      result = const ActionResult.failure('request_cancelled');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } on UnknownNetworkException {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } catch (e) {
      result = const ActionResult.failure('unknown_error');
      _emitUpdateAdminError(currentState, result.errorMessage!);
    } finally {
      _isUpdatingAdmin = false;
    }

    return result;
  }

  void _emitDeleteError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: false,
      deleteError: message,
    ));
  }

  void _emitBanError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: false,
      banActionError: message,
    ));
  }

  void _emitCreateHospitalError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: false,
      createHospitalError: message,
    ));
  }

  void _emitCreateAdminError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: false,
      createAdminError: message,
    ));
  }

  void _emitUpdateDonorError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: false,
      updateDonorError: message,
    ));
  }

  void _emitUpdateHospitalError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: currentState.isUpdatingDonor,
      isUpdatingHospital: false,
      updateHospitalError: message,
    ));
  }

  void _emitUpdateAdminError(UsersSuccessState currentState, String message) {
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isProcessingBan: currentState.isProcessingBan,
      isCreatingHospital: currentState.isCreatingHospital,
      isCreatingAdmin: currentState.isCreatingAdmin,
      isUpdatingDonor: currentState.isUpdatingDonor,
      isUpdatingHospital: currentState.isUpdatingHospital,
      isUpdatingAdmin: false,
      updateAdminError: message,
    ));
  }
}

sealed class UsersState {}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSuccessState extends UsersState {
  final UsersModel usersModel;
  final List<Users> users;
  final bool hasNextPage;
  final bool isLoadingMore;
  final bool isDeleting;
  final String? deleteError;
  final bool isProcessingBan;
  final String? banActionError;
  final bool isCreatingHospital;
  final String? createHospitalError;
  final bool isCreatingAdmin;
  final String? createAdminError;
  final bool isUpdatingDonor;
  final String? updateDonorError;
  final bool isUpdatingHospital;
  final String? updateHospitalError;
  final bool isUpdatingAdmin;
  final String? updateAdminError;

  UsersSuccessState({
    required this.usersModel,
    required this.users,
    this.hasNextPage = false,
    this.isLoadingMore = false,
    this.isDeleting = false,
    this.deleteError,
    this.isProcessingBan = false,
    this.banActionError,
    this.isCreatingHospital = false,
    this.createHospitalError,
    this.isCreatingAdmin = false,
    this.createAdminError,
    this.isUpdatingDonor = false,
    this.updateDonorError,
    this.isUpdatingHospital = false,
    this.updateHospitalError,
    this.isUpdatingAdmin = false,
    this.updateAdminError,
  });
}

class UsersErrorState extends UsersState {
  final String errorMessage;
  UsersErrorState({required this.errorMessage});
}