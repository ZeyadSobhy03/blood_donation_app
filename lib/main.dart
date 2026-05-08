import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/data/locations/location_repository.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/schedule_donation_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/schedule_donation_repositories.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/schedule_donation_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/domain/use_cases/schedule_donation_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/presentation/view_model/schedule_donation_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dio dio = Dio();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await getFCMToken();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DonationScheduleCubit()),
        BlocProvider(create: (context) => MapCubit()),
        BlocProvider(
          create: (context) => ScheduleDonationCubit(
            scheduleDonationUseCase: ScheduleDonationUseCase(
              scheduleDonationRepositories: ScheduleDonationRepositoriesImp(
                scheduleDonationRemoteDataSource: ScheduleDonationApiDataSource(
                  dio,
                ),
              ),
            ),
            locationRepository: LocationRepositoryImpl(),
          ),
        ),
      ],
      child: const BloodDonationApp(),
    ),
  );
}
