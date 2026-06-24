import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../core/errors/app_exceptions.dart';
import '../../../data/model/inbound_email/inbounded_email_model.dart';
import '../../../domain/use_case/inbound_email/inbound_email_use_case.dart';

enum InboundEmailAction { delete, markAsRead, archive }

class InboundEmailCubit extends Cubit<InboundEmailState> {
  final InboundEmailUseCase inboundEmailUseCase;

  InboundEmailCubit({required this.inboundEmailUseCase})
      : super(InboundEmailInitialState());

  int _currentPage = 1;
  final int _limit = 20;
  String? _currentSearch;
  bool _hasNextPage = true;
  bool _isLoadingMore = false;

  List<InboundEmails> _allEmails = [];

  List<InboundEmails> get allEmails => _allEmails;
  bool get hasNextPage => _hasNextPage;

  Future<void> fetchInboundEmails({
    int page = 1,
    String? search,
  }) async {
    _currentPage = page;
    _currentSearch = search;
    emit(InboundEmailLoadingState());
    try {
      final inboundedEmailModel = await inboundEmailUseCase.getInboundedEmail(
        page: page,
        limit: _limit,
        search: search,
      );

      _allEmails = inboundedEmailModel.data?.inboundEmails ?? [];
      _hasNextPage = inboundedEmailModel.data?.pagination?.hasNextPage ?? false;

      emit(InboundEmailSuccessState(
        emails: List.from(_allEmails),
        hasNextPage: _hasNextPage,
      ));
    } on NetworkTimeoutException {
      emit(InboundEmailErrorState(errorKey: 'network_timeout'));
    } on ServerException catch (e) {
      emit(InboundEmailErrorState(errorKey: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(InboundEmailErrorState(errorKey: 'unauthorized'));
    } on NotFoundException {
      emit(InboundEmailErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(InboundEmailErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(InboundEmailErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(InboundEmailErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> loadMoreInboundEmails() async {
    if (_isLoadingMore || !_hasNextPage) return;

    _isLoadingMore = true;
    final nextPage = _currentPage + 1;

    emit(InboundEmailLoadingMoreState(emails: List.from(_allEmails)));

    try {
      final inboundedEmailModel = await inboundEmailUseCase.getInboundedEmail(
        page: nextPage,
        limit: _limit,
        search: _currentSearch,
      );

      _currentPage = nextPage;
      _allEmails = [..._allEmails, ...(inboundedEmailModel.data?.inboundEmails ?? [])];
      _hasNextPage = inboundedEmailModel.data?.pagination?.hasNextPage ?? false;

      emit(InboundEmailSuccessState(
        emails: List.from(_allEmails),
        hasNextPage: _hasNextPage,
      ));
    } on NetworkTimeoutException {
      emit(InboundEmailErrorState(errorKey: 'network_timeout'));
    } on ServerException catch (e) {
      emit(InboundEmailErrorState(errorKey: e.serverMessage ?? 'server_error'));
    } on UnauthorizedException {
      emit(InboundEmailErrorState(errorKey: 'unauthorized'));
    } on NotFoundException {
      emit(InboundEmailErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(InboundEmailErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(InboundEmailErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(InboundEmailErrorState(errorKey: 'unknown_error'));
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> refresh() => fetchInboundEmails(
    page: 1,
    search: _currentSearch,
  );

  Future<void> deleteInboundEmail({required String emailId}) async {
    emit(InboundEmailActionLoadingState(
      emailId: emailId,
      action: InboundEmailAction.delete,
    ));
    try {
      await inboundEmailUseCase.deleteInboundEmail(emailId: emailId);
      emit(InboundEmailActionSuccessState(
        emailId: emailId,
        action: InboundEmailAction.delete,
      ));
      await refresh();
    } on NetworkTimeoutException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'network_timeout',
      ));
    } on ServerException catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: e.serverMessage ?? 'server_error',
      ));
    } on UnauthorizedException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'unauthorized',
      ));
    } on NotFoundException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'not_found',
      ));
    } on RequestCancelledException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'request_cancelled',
      ));
    } on UnknownNetworkException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'unknown_error',
      ));
    } catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.delete,
        errorKey: 'unknown_error',
      ));
    }
  }

  Future<void> markAsReadInboundEmail({required String emailId}) async {
    emit(InboundEmailActionLoadingState(
      emailId: emailId,
      action: InboundEmailAction.markAsRead,
    ));
    try {
      await inboundEmailUseCase.markAsReadInboundEmail(emailId: emailId);
      emit(InboundEmailActionSuccessState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
      ));
      await refresh();
    } on NetworkTimeoutException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'network_timeout',
      ));
    } on ServerException catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: e.serverMessage ?? 'server_error',
      ));
    } on UnauthorizedException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'unauthorized',
      ));
    } on NotFoundException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'not_found',
      ));
    } on RequestCancelledException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'request_cancelled',
      ));
    } on UnknownNetworkException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'unknown_error',
      ));
    } catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.markAsRead,
        errorKey: 'unknown_error',
      ));
    }
  }

  Future<void> archivedInboundEmail({required String emailId}) async {
    emit(InboundEmailActionLoadingState(
      emailId: emailId,
      action: InboundEmailAction.archive,
    ));
    try {
      await inboundEmailUseCase.archivedInboundEmail(emailId: emailId);
      emit(InboundEmailActionSuccessState(
        emailId: emailId,
        action: InboundEmailAction.archive,
      ));
      await refresh();
    } on NetworkTimeoutException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'network_timeout',
      ));
    } on ServerException catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: e.serverMessage ?? 'server_error',
      ));
    } on UnauthorizedException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'unauthorized',
      ));
    } on NotFoundException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'not_found',
      ));
    } on RequestCancelledException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'request_cancelled',
      ));
    } on UnknownNetworkException {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'unknown_error',
      ));
    } catch (e) {
      emit(InboundEmailActionErrorState(
        emailId: emailId,
        action: InboundEmailAction.archive,
        errorKey: 'unknown_error',
      ));
    }
  }
}

sealed class InboundEmailState {}

class InboundEmailInitialState extends InboundEmailState {}

class InboundEmailLoadingState extends InboundEmailState {}

class InboundEmailLoadingMoreState extends InboundEmailState {
  final List<InboundEmails> emails;
  InboundEmailLoadingMoreState({required this.emails});
}

class InboundEmailSuccessState extends InboundEmailState {
  final List<InboundEmails> emails;
  final bool hasNextPage;
  InboundEmailSuccessState({
    required this.emails,
    required this.hasNextPage,
  });
}

class InboundEmailErrorState extends InboundEmailState {
  final String errorKey;
  InboundEmailErrorState({required this.errorKey});
}


class InboundEmailActionLoadingState extends InboundEmailState {
  final String emailId;
  final InboundEmailAction action;
  InboundEmailActionLoadingState({
    required this.emailId,
    required this.action,
  });
}

class InboundEmailActionSuccessState extends InboundEmailState {
  final String emailId;
  final InboundEmailAction action;
  InboundEmailActionSuccessState({
    required this.emailId,
    required this.action,
  });
}

class InboundEmailActionErrorState extends InboundEmailState {
  final String emailId;
  final InboundEmailAction action;
  final String errorKey;
  InboundEmailActionErrorState({
    required this.emailId,
    required this.action,
    required this.errorKey,
  });
}