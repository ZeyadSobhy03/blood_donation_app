import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => DonationScheduleCubit())],
      child: const BloodDonationApp(),
    ),
  );
}
