import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/data_source/history_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/repositories/history_repository.dart';

class HistoryRepositoryImp implements HistoryRepository {
  final HistoryRemoteDataSource historyRemoteDataSource;

  HistoryRepositoryImp({required this.historyRemoteDataSource});

  @override
  Future<HistoryModel> getHistory({
    required String token,
    String? status,
    int page = 1,
    int limit = 10,
  }) {
    return historyRemoteDataSource.getHistory(
      token: token,
      status: status,
      page: page,
      limit: limit,
    );
  }
}