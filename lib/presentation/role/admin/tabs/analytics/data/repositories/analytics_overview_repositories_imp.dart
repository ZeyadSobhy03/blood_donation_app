
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/model/analytics_overview_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/repositories/analytics_overview_repositories.dart';

import '../data_source/remote/analytics_overview_remote_data_source.dart';

class AnalyticsOverviewRepositoriesImp  implements AnalyticsOverviewRepositories{
  final AnalyticsOverviewRemoteDataSource analyticsOverviewRemoteDataSource;
  AnalyticsOverviewRepositoriesImp({required this.analyticsOverviewRemoteDataSource});

  @override
  Future<AnalyticsOverviewModel> getAnalyticsOverview() {
    return analyticsOverviewRemoteDataSource.getAnalyticsOverview();
  }


}