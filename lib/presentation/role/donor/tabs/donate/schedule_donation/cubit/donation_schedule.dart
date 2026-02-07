import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/model/donation_schedule.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationScheduleCubit extends Cubit<DonationScheduleState> {
  DonationScheduleCubit()
    : super(DonationScheduleState(schedule: DonationSchedule()));

  void setLocation(String location) {
    emit(state.copyWith(schedule: state.schedule.copyWith(location: location)));
  }

  void setDate(DateTime date) {
    emit(state.copyWith(schedule: state.schedule.copyWith(date: date)));
  }

  void setTimeSlot(String timeSlot) {
    emit(state.copyWith(schedule: state.schedule.copyWith(timeSlot: timeSlot)));
  }

  void setDonationType(String donationType) {
    emit(
      state.copyWith(
        schedule: state.schedule.copyWith(donationType: donationType),
      ),
    );
  }

  void setFirstName(String firstName) {
    emit(
      state.copyWith(schedule: state.schedule.copyWith(firstName: firstName)),
    );
  }

  void setLastName(String lastName) {
    emit(state.copyWith(schedule: state.schedule.copyWith(lastName: lastName)));
  }

  void setPhone(String phone) {
    emit(state.copyWith(schedule: state.schedule.copyWith(phone: phone)));
  }

  void setEmail(String email) {
    emit(state.copyWith(schedule: state.schedule.copyWith(email: email)));
  }
  void updateFirstName(String name) {
    emit(state.copyWith(
      schedule: state.schedule.copyWith(firstName: name),
    ));
  }

  void updateLastName(String name) {
    emit(state.copyWith(
      schedule: state.schedule.copyWith(lastName: name),
    ));
  }

  void updateEmail(String email) {
    emit(state.copyWith(
      schedule: state.schedule.copyWith(email: email),
    ));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(
      schedule: state.schedule.copyWith(phone: phone),
    ));
  }


// void setBloodType(String bloodType) {
  //   emit(
  //     state.copyWith(schedule: state.schedule.copyWith(bloodType: bloodType)),
  //   );
  // }
}

class DonationScheduleState {
  final DonationSchedule schedule;

  DonationScheduleState({required this.schedule});

  DonationScheduleState copyWith({DonationSchedule? schedule}) {
    return DonationScheduleState(schedule: schedule ?? this.schedule);
  }
}
