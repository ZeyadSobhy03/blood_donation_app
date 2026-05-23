import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/time_slots/time_slots_repositories.dart';

import '../../../data/models/time_slots/time_slots_model.dart';

class TimeSlotsUseCase {

  final TimeSlotsRepositories repository;
  TimeSlotsUseCase({required this.repository});
  Future<TimeSlotsModel> getTimeSlots({
    required String date,
    required String hospitalId,
}) {
    return repository.getTimeSlots(
      date: date,
      hospitalId: hospitalId
    );
  }
}