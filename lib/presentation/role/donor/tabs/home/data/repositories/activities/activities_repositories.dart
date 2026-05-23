import '../../model/activities/activities_model.dart';

abstract class ActivitiesRepositories {
  Future<ActivitiesModel> getActivities({
    int page = 1,
    int limit = 10,
  });

}