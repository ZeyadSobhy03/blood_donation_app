import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/data_source/remote/analytics/analytics_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_donations_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/model/analytics/analytics_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/repositories/analytics/analytics_repositories.dart';

class AnalyticsRepositoriesImp  implements AnalyticsRepositories{
  final AnalyticsRemoteDataSource analyticsRemoteDataSource;
  AnalyticsRepositoriesImp({required this.analyticsRemoteDataSource});

  @override
  Future<AnalyticsModel> getAnalytics() {
    return analyticsRemoteDataSource.getAnalytics();
  }

  @override
  Future<AnalyticsDonationsModel> getAnalyticsDonations() {
    return analyticsRemoteDataSource.getAnalyticsDonations();
  }

}