import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/users_use_case.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersUseCase usersUseCase;

  UsersCubit({required this.usersUseCase}) : super(UsersInitialState());

  final int _limit = 10;
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;
  bool _isDeleting = false;
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

  Future<void> deleteUser({required String userId}) async {
    if (_isDeleting) return;

    final currentState = state;
    if (currentState is! UsersSuccessState) return;

    _isDeleting = true;
    emit(UsersSuccessState(
      usersModel: currentState.usersModel,
      users: List.of(_allUsers),
      hasNextPage: _hasNextPage,
      isLoadingMore: currentState.isLoadingMore,
      isDeleting: true,
    ));

    try {
      final deleteUserModel = await usersUseCase.deleteUser(userId: userId);
      if (deleteUserModel.success == true) {
        await getUsers(role: _role, search: _search);
      } else {
        emit(UsersSuccessState(
          usersModel: currentState.usersModel,
          users: List.of(_allUsers),
          hasNextPage: _hasNextPage,
          isLoadingMore: currentState.isLoadingMore,
          isDeleting: false,
          deleteError: deleteUserModel.message ?? 'failed_to_delete_user',
        ));
      }
    } on NetworkTimeoutException {
      _emitDeleteError(currentState, 'network_timeout');
    } on UnauthorizedException catch (e) {
      _emitDeleteError(currentState, e.message ?? 'unauthorized');
    } on ServerException catch (e) {
      _emitDeleteError(currentState, e.serverMessage ?? 'server_error');
    } on NotFoundException {
      _emitDeleteError(currentState, 'not_found');
    } on RequestCancelledException {
      _emitDeleteError(currentState, 'request_cancelled');
    } on UnknownNetworkException {
      _emitDeleteError(currentState, 'unknown_error');
    } catch (e) {
      _emitDeleteError(currentState, 'unknown_error');
    } finally {
      _isDeleting = false;
    }
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

  UsersSuccessState({
    required this.usersModel,
    required this.users,
    this.hasNextPage = false,
    this.isLoadingMore = false,
    this.isDeleting = false,
    this.deleteError,
  });
}

class UsersErrorState extends UsersState {
  final String errorMessage;
  UsersErrorState({required this.errorMessage});
}