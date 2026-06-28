import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';

abstract class HistoryRepository {
  Future<HistoryModel> getHistory({
    required String token,
    String? status,
    int page,
    int limit,
  });
}