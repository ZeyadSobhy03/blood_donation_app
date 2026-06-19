import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/repositories/analytics_overview_repositories.dart';

import '../../data/model/analytics_overview_model.dart';

class AnalyticsOverviewUseCase {
  final AnalyticsOverviewRepositories analyticsOverviewRepositories;
  AnalyticsOverviewUseCase({required this.analyticsOverviewRepositories});
  Future<AnalyticsOverviewModel> getAnalyticsOverview(){
    return analyticsOverviewRepositories.getAnalyticsOverview();
  }

}