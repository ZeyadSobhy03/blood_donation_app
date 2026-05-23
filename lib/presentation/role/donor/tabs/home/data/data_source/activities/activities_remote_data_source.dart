import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/activities/activities_model.dart';

abstract class ActivitiesRemoteDataSource {
  Future<ActivitiesModel> getActivities({
    int page = 1,
    int limit = 10,
});
}
