import 'dart:async';
import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/model/answer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/ask_use_case.dart';



class AskCubit extends Cubit<AskState> {
  final AskUseCase askUseCase;
  StreamSubscription<String>? _streamSubscription;

  AskCubit({required this.askUseCase}) : super(AskInitialState());

  // ── Normal single response ───────────────

  Future<void> askQuestion(String question, String userId) async {
    try {
      emit(AskLoadingState());
      final answer = await askUseCase.askQuestion(
        question: question,
        userId: userId,
      );
      emit(AskSuccessState(answer));
    } on NetworkTimeoutException {
      emit(AskErrorState('network_timeout'));
    } on ServerException catch (e) {
      emit(AskErrorState(mapServerErrorToKey(e.serverMessage)));
    } on UnauthorizedException {
      emit(AskErrorState('unauthorized'));
    } on RequestCancelledException {
      emit(AskErrorState('request_cancelled'));
    } on UnknownNetworkException {
      emit(AskErrorState('unknown_error'));
    } catch (e) {
      emit(AskErrorState('unknown_error'));
    }
  }

  // ── Streaming response (for voice) ───────

  Future<void> askQuestionStream(String question, String userId) async {
    try {
      // Cancel any previous stream
      await _streamSubscription?.cancel();

      emit(AskLoadingState());

      String fullAnswer = '';

      _streamSubscription = askUseCase
          .askQuestionStream(question: question, userId: userId)
          .listen(
            (token) {
          fullAnswer += token;
          emit(AskStreamingState(
            currentText: fullAnswer,
            question: question,
          ));
        },
        onDone: () {
          emit(AskSuccessState(
            AnswerModel(
              answer: fullAnswer,
            ),
          ));
        },
        onError: (e) {
          if (e is ServerException) {
            emit(AskErrorState(mapServerErrorToKey(e.serverMessage)));
          } else if (e is NetworkTimeoutException) {
            emit(AskErrorState('network_timeout'));
          } else {
            emit(AskErrorState('unknown_error'));
          }
        },
      );
    } catch (e) {
      emit(AskErrorState('unknown_error'));
    }
  }

  // ── Stop stream ──────────────────────────

  Future<void> stopStream() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    emit(AskInitialState());
  }

  // ── Reset ────────────────────────────────

  void reset() {
    _streamSubscription?.cancel();
    emit(AskInitialState());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

// ─────────────────────────────────────────
// STATES
// ─────────────────────────────────────────

sealed class AskState {}

class AskInitialState extends AskState {}

class AskLoadingState extends AskState {}

class AskStreamingState extends AskState {
  final String currentText;  // grows token by token
  final String question;

  AskStreamingState({
    required this.currentText,
    required this.question,
  });
}

class AskSuccessState extends AskState {
  final AnswerModel answer;
  AskSuccessState(this.answer);
}

class AskErrorState extends AskState {
  final String error;
  AskErrorState(this.error);
}