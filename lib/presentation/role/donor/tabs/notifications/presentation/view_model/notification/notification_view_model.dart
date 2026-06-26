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
  int _unreadCount = 0;

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
    } else {
      // Emit current state with loading-more flag so UI can show a bottom loader
      emit(
        NotificationPaginationLoadingState(
          notifications: List.from(_allNotifications),
          unreadCount: _unreadCount,
        ),
      );
    }

    try {
      final response = await notificationUseCase.getNotifications(
        page: _currentPage,
        limit: _pageSize,
      );

      final newNotifications = response.data?.notifications ?? [];
      _unreadCount = response.data?.unreadCount ?? 0;

      final pagination = response.data?.pagination;
      _hasNextPage = (pagination?.page != null && pagination?.pages != null)
          ? pagination!.page! < pagination.pages!
          : false;

      _allNotifications.addAll(newNotifications);

      emit(
        NotificationSuccessState(
          notifications: List.from(_allNotifications),
          unreadCount: _unreadCount,
          hasNextPage: _hasNextPage,
        ),
      );

      if (_hasNextPage) {
        _currentPage++;
      }
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
    } finally {
      _isFetching = false;
    }
  }
}

sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationPaginationLoadingState extends NotificationState {
  final List<Notifications> notifications;
  final int unreadCount;

  NotificationPaginationLoadingState({
    required this.notifications,
    required this.unreadCount,
  });
}

class NotificationSuccessState extends NotificationState {
  final List<Notifications> notifications;
  final int unreadCount;
  final bool hasNextPage;

  NotificationSuccessState({
    required this.notifications,
    required this.unreadCount,
    required this.hasNextPage,
  });
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState(this.message);
}

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
