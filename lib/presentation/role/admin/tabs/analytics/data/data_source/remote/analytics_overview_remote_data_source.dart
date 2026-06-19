import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/model/analytics_overview_model.dart';

abstract class AnalyticsOverviewRemoteDataSource {

  Future<AnalyticsOverviewModel> getAnalyticsOverview();
}