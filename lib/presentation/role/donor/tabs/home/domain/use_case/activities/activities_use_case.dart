import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/activities/activities_repositories.dart';

import '../../../data/model/activities/activities_model.dart';

class ActivitiesUseCase {

  final ActivitiesRepositories repository;
  ActivitiesUseCase({required this.repository});
  Future<ActivitiesModel> getActivities({
    int page = 1,
    int limit = 10,
  }) {
    return repository.getActivities(page: page, limit: limit);
  }
}