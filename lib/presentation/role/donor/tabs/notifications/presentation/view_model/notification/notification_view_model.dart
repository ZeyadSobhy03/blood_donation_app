import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/notification/notification_use_case.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationUseCase notificationUseCase;

  NotificationCubit({required this.notificationUseCase})
    : super(NotificationInitialState());

  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasNextPage = true;
  bool _isFetching = false;
  final List<Notifications> _allNotifications = [];

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (_isFetching) return;

    if (isRefresh) {
      _currentPage = 1;
      _hasNextPage = true;

      _allNotifications.clear();
    }

    if (!_hasNextPage) return;

    _isFetching = true;

    if (_currentPage == 1) {
      emit(NotificationLoadingState());
    }

    try {
      final notifications = await notificationUseCase.getNotifications(
        page: _currentPage,
        limit: _pageSize,
      );
      emit(NotificationSuccessState(notifications));
    } on NetworkTimeoutException {
      emit(NotificationErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(NotificationErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(NotificationErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(NotificationErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(NotificationErrorState('unknown_error'));
    } catch (e) {
      emit(NotificationErrorState('unknown_error'));
    }
  }
}

sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationSuccessState extends NotificationState {
  final NotificationsModel notifications;

  NotificationSuccessState(this.notifications);
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState(this.message);
}

////////////////////////////////////////

class NotificationAllReadCubit extends Cubit<NotificationAllReadState> {
  final NotificationUseCase notificationUseCase;

  NotificationAllReadCubit({required this.notificationUseCase})
    : super(NotificationAllReadInitialState());

  Future<void> markAllAsRead() async {
    emit(NotificationAllReadLoadingState());
    try {
      final result = await notificationUseCase.markAsAllAsRead();
      emit(NotificationAllReadSuccessState(result));
    } on NetworkTimeoutException {
      emit(NotificationAllReadErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(NotificationAllReadErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(NotificationAllReadErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(NotificationAllReadErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(NotificationAllReadErrorState('unknown_error'));
    } catch (e) {
      emit(NotificationAllReadErrorState('unknown_error'));
    }
  }
}

sealed class NotificationAllReadState {}

class NotificationAllReadInitialState extends NotificationAllReadState {}

class NotificationAllReadLoadingState extends NotificationAllReadState {}

class NotificationAllReadSuccessState extends NotificationAllReadState {
  final NotificationsModel notificationAllReadModel;

  NotificationAllReadSuccessState(this.notificationAllReadModel);
}

class NotificationAllReadErrorState extends NotificationAllReadState {
  final String message;

  NotificationAllReadErrorState(this.message);
}

////////////////////////////////////////

class NotificationDeleteCubit extends Cubit<NotificationDeleteState> {
  final NotificationUseCase notificationUseCase;

  NotificationDeleteCubit({required this.notificationUseCase})
    : super(NotificationDeleteInitialState());

  Future<void> deleteNotifications() async {
    emit(NotificationDeleteLoadingState());
    try {
      await notificationUseCase.deleteNotifications();
      emit(NotificationDeleteSuccessState());
    } on NetworkTimeoutException {
      emit(NotificationDeleteErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(NotificationDeleteErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(NotificationDeleteErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(NotificationDeleteErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(NotificationDeleteErrorState('unknown_error'));
    } catch (e) {
      emit(NotificationDeleteErrorState('unknown_error'));
    }
  }
}

sealed class NotificationDeleteState {}

class NotificationDeleteInitialState extends NotificationDeleteState {}

class NotificationDeleteLoadingState extends NotificationDeleteState {}

class NotificationDeleteSuccessState extends NotificationDeleteState {
  final String message;

  NotificationDeleteSuccessState({this.message = 'delete_success'});
}

class NotificationDeleteErrorState extends NotificationDeleteState {
  final String message;

  NotificationDeleteErrorState(this.message);
}
