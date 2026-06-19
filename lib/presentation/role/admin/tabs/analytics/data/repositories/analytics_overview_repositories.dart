import '../model/analytics_overview_model.dart';

abstract class AnalyticsOverviewRepositories {

  Future<AnalyticsOverviewModel> getAnalyticsOverview();

}