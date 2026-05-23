import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/repositories/ask_repositories.dart';

import '../../data/model/answer_model.dart';

class AskUseCase {
  final AskRepositories repository;
  AskUseCase({required this.repository});
  Future<AnswerModel> askQuestion({
    required String question,
    required String userId,
  }) {
    return repository.askQuestion(
      question: question,
      userId: userId,
    );
  }
  Stream<String> askQuestionStream({
    required String question,
    required String userId,
  }) {
    return repository.askQuestionStream(
      question: question,
      userId: userId,
    );
  }
}