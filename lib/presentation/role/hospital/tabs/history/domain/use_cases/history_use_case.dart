import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/repositories/history_repository.dart';

class HistoryUseCase {
  final HistoryRepository historyRepository;

  HistoryUseCase({required this.historyRepository});

  Future<HistoryModel> call({
    required String token,
    String? status,
    int page = 1,
    int limit = 10,
  }) {
    return historyRepository.getHistory(
      token: token,
      status: status,
      page: page,
      limit: limit,
    );
  }
}