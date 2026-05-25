import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/data/locations/location_repository.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_api_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories_imp.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/schedule_donation_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/schedule_donation_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/domain/use_cases/schedule_donation_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/presentation/view_model/schedule_donation_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/api_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donor_states_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donor_states_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/profile_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/profile_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/profile_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/data_source/find_donors_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/data/repositories/find_donors_repository_imp.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/domain/use_cases/find_donors_use_case.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/presentation/view_model/find_donors_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce/hive.dart';
import 'firebase_options.dart';
import 'notifications.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
  Dio dio = Dio();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authHiveDataSource = AuthHiveDataSource();
  final hospitalHiveDataSource = HospitalHiveDataSource();

  await authHiveDataSource.init();
  await hospitalHiveDataSource.init();
  await getFCMToken();
  runApp(
    RepositoryProvider<HospitalHiveDataSource>.value(
      value: hospitalHiveDataSource,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DonationScheduleCubit()),
          BlocProvider(create: (context) => MapCubit()),
          BlocProvider(
            create: (context) => FindDonorsCubit(
              hospitalLocalDataSource: hospitalHiveDataSource,
              findDonorsUseCase: FindDonorsUseCase(
                findDonorsRepository: FindDonorsRepositoryImp(
                  findDonorsRemoteDataSource: FindDonorsApiDataSource(dio)
                ),

              ),
            ),
          ),
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
          BlocProvider(
            create: (context) => DonorStatesCubit(
              donorStatesUseCase: DonorStatesUseCase(
                donorStatesRepositories: DonorStatesRepositoriesImp(
                  remoteDonorStatesDataSource: ApiDonorStatesDataSource(
                    dio,
                    authHiveDataSource,
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AuthCubit(
              authUseCase: AuthUseCase(
                authRepositories: AuthRepositoriesImp(
                  authRemoteDataSource: AuthApiDataSource(dio),
                ),
              ),
              authHiveDataSource: authHiveDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              profileUseCase: ProfileUseCase(
                profileRepositories: ProfileRepositoriesImp(
                  profileRemoteDataSource: ProfileApiDataSource(
                    dio,
                    authHiveDataSource,
                  ),
                ),
              ),
            ),
          ),
        ],
        child: const BloodDonationApp(),
      ),
    ),
  );
}
