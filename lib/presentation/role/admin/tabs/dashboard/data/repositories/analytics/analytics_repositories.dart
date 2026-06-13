import '../../model/analytics/analytics_donations_model.dart';
import '../../model/analytics/analytics_model.dart';

abstract class AnalyticsRepositories {
  Future<AnalyticsModel> getAnalytics();
  Future<AnalyticsDonationsModel>getAnalyticsDonations();


}