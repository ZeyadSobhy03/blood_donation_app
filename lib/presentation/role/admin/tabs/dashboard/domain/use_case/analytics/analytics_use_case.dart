import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/repositories/analytics/analytics_repositories.dart';

import '../../../data/model/analytics/analytics_donations_model.dart';
import '../../../data/model/analytics/analytics_model.dart';

class AnalyticsUseCase {
  final AnalyticsRepositories analyticsRepositories;
  AnalyticsUseCase({required this.analyticsRepositories});
  Future<AnalyticsModel> getAnalytics() {
    return analyticsRepositories.getAnalytics();
  }
  Future<AnalyticsDonationsModel>getAnalyticsDonations(){
    return analyticsRepositories.getAnalyticsDonations();
  }
}