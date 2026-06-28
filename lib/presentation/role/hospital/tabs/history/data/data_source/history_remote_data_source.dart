import 'package:blood_donation_app/presentation/role/hospital/tabs/history/data/model/history_model.dart';

abstract class HistoryRemoteDataSource {
  /// GET /hospital/history
  ///
  /// [token]  — hospital JWT access token (required, 401 if missing/invalid).
  /// [status] — optional filter: "completed" | "cancelled" | "active".
  ///            Omit to retrieve all statuses.
  /// [page]   — page number (default 1).
  /// [limit]  — page size (default 10).
  Future<HistoryModel> getHistory({
    required String token,
    String? status,
    int page,
    int limit,
  });
}