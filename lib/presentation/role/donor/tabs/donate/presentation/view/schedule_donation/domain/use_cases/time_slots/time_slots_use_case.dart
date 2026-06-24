
import '../../../data/models/time_slots/time_slots_model.dart';
import '../../../data/repositories/time_slots/time_slots_repositories.dart';

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