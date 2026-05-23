import 'dart:convert';
import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/data_source/ask_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/model/answer_model.dart';
import 'package:dio/dio.dart';

class AskApiDataSource implements AskRemoteDataSource {
  final Dio dio;

  AskApiDataSource(this.dio);


  @override
  Future<AnswerModel> askQuestion({
    required String question,
    required String userId,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.askChatBotEndpoint,
        data: {'message': question, 'user_id': userId},
      );

      if (response.statusCode == 200) {
        return AnswerModel.fromJson(response.data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get answer: $e');
    }
  }



  @override
  Stream<String> askQuestionStream({
    required String question,
    required String userId,
  }) async* {
    try {
      final response = await dio.post(
        ApiManger.chatEndPoint,
        data: {'message': question, 'user_id': userId},
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final responseBody = response.data as ResponseBody;

      await for (final bytes in responseBody.stream) {
        final chunk = utf8.decode(bytes);
        final lines = chunk.split('\n');

        for (final line in lines) {
          if (line.startsWith('data: ') && !line.contains('[DONE]')) {
            try {
              final jsonStr = line.substring(6);
              final json = jsonDecode(jsonStr) as Map<String, dynamic>;
              final token = json['text'] as String? ?? '';
              if (token.isNotEmpty) yield token;
            } catch (_) {}
          }
        }
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Stream error: $e');
    }
  }
}