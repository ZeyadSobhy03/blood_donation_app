import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'notifications.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await getFCMToken();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DonationScheduleCubit()),
        BlocProvider(create: (context) => MapCubit()),
      ],
      child: const BloodDonationApp(),
    ),
  );
}
