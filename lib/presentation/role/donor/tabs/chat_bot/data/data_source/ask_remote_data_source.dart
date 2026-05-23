import '../model/answer_model.dart';

abstract class AskRemoteDataSource {
  Future<AnswerModel> askQuestion({
    required String question,
    required String userId,
  });
  Stream<String> askQuestionStream({
    required String question,
    required String userId,
  });


}
