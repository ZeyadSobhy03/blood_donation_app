import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/notification/notifications_model.dart';
import '../../../domain/use_cases/notification/notification_use_case.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationUseCase notificationUseCase;

  NotificationCubit({required this.notificationUseCase})
    : super(NotificationInitialState());

  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasNextPage = true;
  bool _isFetching = false;
  final List<NotificationItem> _allNotifications = [];
  int _unreadCount = 0;

  Future<void> fetchNotifications({
    required String accessToken,
    bool isRefresh = false,
  }) async {
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
      emit(NotificationPaginationLoadingState(
        notifications: List.from(_allNotifications),
        unreadCount: _unreadCount,
      ));
    }

    try {
      final response = await notificationUseCase.getNotifications(
        page: _currentPage,
        limit: _pageSize,
        accessToken: accessToken,
      );

      final newNotifications = response.data?.notifications ?? [];
      _unreadCount = response.data?.unreadCount ?? 0;

      final pagination = response.data?.pagination;
      _hasNextPage = (pagination?.page != null && pagination?.pages != null)
        ? pagination!.page! < pagination.pages!
        : false;

      _allNotifications.addAll(newNotifications);

      emit(NotificationSuccessState(
        notifications: List.from(_allNotifications),
        unreadCount: _unreadCount,
        hasNextPage: _hasNextPage,
      ));

      if (_hasNextPage) {
        _currentPage++;
      }
    } catch (e) {
      emit(NotificationErrorState(_parseError(e.toString())));
    } finally {
      _isFetching = false;
    }
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return 'network_timeout';
    if (e.contains('unauthorized')) return 'unauthorized';
    if (e.contains('unknown_error')) return 'unknown_error';
    return 'unknown_error';
  }
}

sealed class NotificationState {}

class NotificationInitialState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationPaginationLoadingState extends NotificationState {
  final List<NotificationItem> notifications;
  final int unreadCount;

  NotificationPaginationLoadingState({
    required this.notifications,
    required this.unreadCount,
  });
}

class NotificationSuccessState extends NotificationState {
  final List<NotificationItem> notifications;
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

  Future<void> markAllAsRead({required String accessToken}) async {
    emit(NotificationAllReadLoadingState());
    try {
      final result = await notificationUseCase.markAllAsRead(accessToken: accessToken);
      emit(NotificationAllReadSuccessState(result));
    } catch (e) {
      emit(NotificationAllReadErrorState(_parseError(e.toString())));
    }
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return 'network_timeout';
    return 'unknown_error';
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

class NotificationDeleteCubit extends Cubit<NotificationDeleteState> {
  final NotificationUseCase notificationUseCase;

  NotificationDeleteCubit({required this.notificationUseCase})
    : super(NotificationDeleteInitialState());

  Future<void> deleteNotifications({required String accessToken}) async {
    emit(NotificationDeleteLoadingState());
    try {
      await notificationUseCase.deleteAllNotifications(accessToken: accessToken);
      emit(NotificationDeleteSuccessState());
    } catch (e) {
      emit(NotificationDeleteErrorState(_parseError(e.toString())));
    }
  }

  String _parseError(String error) {
    final e = error.toLowerCase();
    if (e.contains('timeout')) return 'network_timeout';
    return 'unknown_error';
  }
}

sealed class NotificationDeleteState {}

class NotificationDeleteInitialState extends NotificationDeleteState {}

class NotificationDeleteLoadingState extends NotificationDeleteState {}

class NotificationDeleteSuccessState extends NotificationDeleteState {
  final String message;
  NotificationDeleteSuccessState({this.message = 'Notifications deleted successfully'});
}

class NotificationDeleteErrorState extends NotificationDeleteState {
  final String message;
  NotificationDeleteErrorState(this.message);
}
