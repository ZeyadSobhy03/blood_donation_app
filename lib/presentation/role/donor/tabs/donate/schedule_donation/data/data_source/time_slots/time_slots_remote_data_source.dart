import '../../models/time_slots/time_slots_model.dart';

abstract class TimeSlotsRemoteDataSource {
  Future<TimeSlotsModel> getTimeSlots({
    required String date,
    required String hospitalId,
});
}