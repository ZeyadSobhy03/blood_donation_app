import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/activities/activities_remote_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/activities/activities_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/activities/activities_repositories.dart';

class ActivitiesRepositoriesImp implements ActivitiesRepositories {

  final ActivitiesRemoteDataSource activitiesRemoteDataSource;
  ActivitiesRepositoriesImp({required this.activitiesRemoteDataSource});

  @override
  Future<ActivitiesModel> getActivities({int page = 1, int limit = 10}) {
    return activitiesRemoteDataSource.getActivities(page: page, limit: limit);
  }
}