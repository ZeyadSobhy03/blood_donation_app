import 'dart:developer';

import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/model/support_tickets/support_tickets_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/error_localizer.dart';
import '../../../domain/use_case/support_tickets/support_tickets_use_case.dart';

class SupportTicketsCubit extends Cubit<SupportTicketsState> {
  final SupportTicketsUseCase supportTicketsUseCase;

  SupportTicketsCubit({required this.supportTicketsUseCase})
      : super(SupportTicketsInitialState());

  Future<void> fetchSupportTickets() async {
    emit(SupportTicketsLoadingState());
    try {
      final model = await supportTicketsUseCase.getSupportTickets();
      emit(SupportTicketsSuccessState(ticketsModel: model));
    } on NetworkTimeoutException {
      log('[SupportTicketsCubit] fetchSupportTickets: NetworkTimeoutException');
      emit(SupportTicketsErrorState(error: 'network_timeout'));
    } on NetworkConnectionException {
      log('[SupportTicketsCubit] fetchSupportTickets: NetworkConnectionException');
      emit(SupportTicketsErrorState(error: 'no_internet'));
    } on ServerException catch (e) {
      log('[SupportTicketsCubit] fetchSupportTickets: ServerException ${e.statusCode} ${e.serverMessage}');
      emit(SupportTicketsErrorState(
          error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      log('[SupportTicketsCubit] fetchSupportTickets: UnauthorizedException');
      emit(SupportTicketsErrorState(error: 'unauthorized'));
    } on NotFoundException {
      log('[SupportTicketsCubit] fetchSupportTickets: NotFoundException');
      emit(SupportTicketsErrorState(error: 'not_found'));
    } on RequestCancelledException {
      log('[SupportTicketsCubit] fetchSupportTickets: RequestCancelledException');
      emit(SupportTicketsErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      log('[SupportTicketsCubit] fetchSupportTickets: UnknownNetworkException');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    } catch (e) {
      log('[SupportTicketsCubit] fetchSupportTickets: Unhandled error: $e');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    }
  }

  Future<SupportTicketDetailModel?> fetchTicketDetail(String ticketId) async {
    try {
      return await supportTicketsUseCase.getSupportTicketDetail(ticketId);
    } on NetworkTimeoutException {
      log('[SupportTicketsCubit] fetchTicketDetail: NetworkTimeoutException');
      emit(SupportTicketsErrorState(error: 'network_timeout'));
    } on NetworkConnectionException {
      log('[SupportTicketsCubit] fetchTicketDetail: NetworkConnectionException');
      emit(SupportTicketsErrorState(error: 'no_internet'));
    } on ServerException catch (e) {
      log('[SupportTicketsCubit] fetchTicketDetail: ServerException ${e.statusCode} ${e.serverMessage}');
      emit(SupportTicketsErrorState(
          error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      log('[SupportTicketsCubit] fetchTicketDetail: UnauthorizedException');
      emit(SupportTicketsErrorState(error: 'unauthorized'));
    } on NotFoundException {
      log('[SupportTicketsCubit] fetchTicketDetail: NotFoundException');
      emit(SupportTicketsErrorState(error: 'not_found'));
    } on RequestCancelledException {
      log('[SupportTicketsCubit] fetchTicketDetail: RequestCancelledException');
      emit(SupportTicketsErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      log('[SupportTicketsCubit] fetchTicketDetail: UnknownNetworkException');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    } catch (e) {
      log('[SupportTicketsCubit] fetchTicketDetail: Unhandled error: $e');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    }
    return null;
  }

  Future<bool> replyToTicket(String ticketId, String reply) async {
    try {
      await supportTicketsUseCase.replyToSupportTicket(ticketId, reply);
      return true;
    } on NetworkTimeoutException {
      log('[SupportTicketsCubit] replyToTicket: NetworkTimeoutException');
      emit(SupportTicketsErrorState(error: 'network_timeout'));
    } on NetworkConnectionException {
      log('[SupportTicketsCubit] replyToTicket: NetworkConnectionException');
      emit(SupportTicketsErrorState(error: 'no_internet'));
    } on ServerException catch (e) {
      log('[SupportTicketsCubit] replyToTicket: ServerException ${e.statusCode} ${e.serverMessage}');
      emit(SupportTicketsErrorState(
          error: mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      log('[SupportTicketsCubit] replyToTicket: UnauthorizedException');
      emit(SupportTicketsErrorState(error: 'unauthorized'));
    } on NotFoundException {
      log('[SupportTicketsCubit] replyToTicket: NotFoundException');
      emit(SupportTicketsErrorState(error: 'not_found'));
    } on RequestCancelledException {
      log('[SupportTicketsCubit] replyToTicket: RequestCancelledException');
      emit(SupportTicketsErrorState(error: 'request_cancelled'));
    } on UnknownNetworkException {
      log('[SupportTicketsCubit] replyToTicket: UnknownNetworkException');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    } catch (e) {
      log('[SupportTicketsCubit] replyToTicket: Unhandled error: $e');
      emit(SupportTicketsErrorState(error: 'unknown_error'));
    }
    return false;
  }

  void reset() => emit(SupportTicketsInitialState());
}

sealed class SupportTicketsState {}

class SupportTicketsInitialState extends SupportTicketsState {}

class SupportTicketsLoadingState extends SupportTicketsState {}

class SupportTicketsSuccessState extends SupportTicketsState {
  final SupportTicketsModel ticketsModel;
  SupportTicketsSuccessState({required this.ticketsModel});
}

class SupportTicketsErrorState extends SupportTicketsState {
  final String error;
  SupportTicketsErrorState({required this.error});
}
