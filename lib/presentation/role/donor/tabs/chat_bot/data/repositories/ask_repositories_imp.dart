import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/model/answer_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/repositories/ask_repositories.dart';

import '../data_source/ask_remote_data_source.dart';

class AskRepositoriesImp implements AskRepositories {
  final AskRemoteDataSource askRemoteDataSource;
  AskRepositoriesImp({required this.askRemoteDataSource});
  @override

  Future<AnswerModel> askQuestion({required String question, required String userId}) {
    return askRemoteDataSource.askQuestion(question: question, userId: userId);
  }

  @override
  Stream<String> askQuestionStream({required String question, required String userId}) {
    return askRemoteDataSource.askQuestionStream(question: question, userId: userId);
  }

}