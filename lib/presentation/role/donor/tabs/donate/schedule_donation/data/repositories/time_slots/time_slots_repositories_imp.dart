import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/models/time_slots/time_slots_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/time_slots/time_slots_repositories.dart';

import '../../data_source/time_slots/time_slots_remote_data_source.dart';

class TimeSlotsRepositoriesImp implements TimeSlotsRepositories {

  final TimeSlotsRemoteDataSource remoteDataSource;
  TimeSlotsRepositoriesImp({required this.remoteDataSource});

  @override
  Future<TimeSlotsModel> getTimeSlots({
    required String date,
    required String hospitalId,
}) {
    return remoteDataSource.getTimeSlots(
      hospitalId: hospitalId,
      date: date
    );
  }

}