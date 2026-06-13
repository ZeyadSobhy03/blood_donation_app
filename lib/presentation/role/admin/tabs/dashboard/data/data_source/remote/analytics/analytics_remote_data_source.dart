import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_donations_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_model.dart';

abstract class AnalyticsRemoteDataSource {
  Future<AnalyticsModel> getAnalytics();
  Future<AnalyticsDonationsModel>getAnalyticsDonations();
}