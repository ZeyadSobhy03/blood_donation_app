import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_api_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories_imp.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/data_source/ask_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/repositories/ask_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/domain/use_case/ask_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/presentation/view_model/ask_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/appointments_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/domain/use_case/appointments_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/appointments_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/cubit/donation_schedule.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/data_source/time_slots/time_slots_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/data/repositories/time_slots/time_slots_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/domain/use_cases/time_slots/time_slots_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/presentation/view_model/time_slots/time_slots_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/data_source/donation_history_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/repositories/donation_history_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/domain/use_case/donation_history_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view_model/donation_history_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/data_source/nearby_hospitals_api_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/repositories/nearby_hospitals_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/domain/use_case/nearby_hospitals_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view_model/nearby_hospitals_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/activities/activities_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/local/hive_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/remote/api_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/requests/requests_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/activities/activities_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states/donor_states_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/requests/requests_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/activities/activities_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donor_states/donor_states_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/requests/requests_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/activities/activities_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donor_states/donor_states_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/requests/accept_request_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/requests/cancel_request_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/requests/requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/fcm/fcm_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/notification/local/notification_local_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/data_source/notification/remote/notification_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/repositories/fcm/fcm_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/repositories/notification/notification_repository_impl.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/domain/use_cases/fcm/fcm_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/domain/use_cases/notification/notification_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view_model/fcm/fcm_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view_model/notification/notification_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/profile/profile_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/setting/setting_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/profile/profile_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/setting/setting_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/profile/profile_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/setting/setting_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/setting/setting_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/data_source/rewards_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/data/repositories/rewards_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/domain/use_case/rewards_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/earning_rules_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/history_cubit.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/rewards_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/presentation/view_model/user_points_view_model.dart';
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
  final hiveDonorStatesDataSource = HiveDonorStatesDataSource();
  final hiveNotificationDataSource = HiveNotificationDataSource();
  await hiveNotificationDataSource.init();

  await authHiveDataSource.init();
  await hiveDonorStatesDataSource.init();
  await getFCMToken();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DonationScheduleCubit()),
        BlocProvider(create: (context) => MapCubit()),

        BlocProvider(
          create: (context) => DonorStatesCubit(
            donorStatesUseCase: DonorStatesUseCase(
              donorStatesRepositories: DonorStatesRepositoriesImp(
                remoteDonorStatesDataSource: ApiDonorStatesDataSource(
                  dio,
                  authHiveDataSource,
                ),
                localDonorStatesDataSource: hiveDonorStatesDataSource,
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
        BlocProvider(
          create: (context) => NearbyHospitalsCubit(
            nearbyHospitalsUseCase: NearbyHospitalsUseCase(
              nearbyHospitalsRepositories: NearbyHospitalsRepositoriesImp(
                nearbyHospitalsRemoteDataSource: NearbyHospitalsApiSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AppointmentsCubit(
            appointmentsUseCase: AppointmentsUseCase(
              appointmentsRepositories: AppointmentsRepositoriesImp(
                appointmentsRemoteDataSource: AppointmentsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AskCubit(
            askUseCase: AskUseCase(
              repository: AskRepositoriesImp(
                askRemoteDataSource: AskApiDataSource(dio),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => RewardsCubit(
            rewardsUseCase: RewardsUseCase(
              repository: RewardsRepositoriesImp(
                rewardsRemoteDataSource: RewardsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(
            rewardsUseCase: RewardsUseCase(
              repository: RewardsRepositoriesImp(
                rewardsRemoteDataSource: RewardsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(
            notificationUseCase: NotificationUseCase(
              repository: NotificationRepositoryImpl(
                localDataSource: hiveNotificationDataSource,
                notificationRemoteDataSource: NotificationApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(create: (context) => NotificationAllReadCubit(notificationUseCase: NotificationUseCase(repository: NotificationRepositoryImpl(
            localDataSource: hiveNotificationDataSource,
            notificationRemoteDataSource: NotificationApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => FcmCubit(fcmUseCase: FcmUseCase(repository: FcmRepositoriesImp(fcmRemoteDataSource: FcmApiDataSource(dio,authHiveDataSource)))),),
        BlocProvider(
          create: (context) => TimeSlotsCubit(timeSlotsUseCase: TimeSlotsUseCase(repository: TimeSlotsRepositoriesImp(remoteDataSource: TimeSlotsApiDataSource(dio, authHiveDataSource)))),

        ),
        BlocProvider(create: (context) => SettingCubit(settingUseCase: SettingUseCase(settingRepositories: SettingRepositoriesImp(settingRemoteDataSource: SettingApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => EarningRulesCubit(rewardsUseCase: RewardsUseCase(repository: RewardsRepositoriesImp(rewardsRemoteDataSource: RewardsApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => UserPointsCubit(rewardsUseCase: RewardsUseCase(repository: RewardsRepositoriesImp(rewardsRemoteDataSource: RewardsApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => RequestsCubit(requestsUseCase: RequestsUseCase(repository: RequestsRepositoriesImp(requestsRemoteDataSource: RequestsApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => AcceptRequestCubit(requestsUseCase: RequestsUseCase(repository: RequestsRepositoriesImp(requestsRemoteDataSource: RequestsApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => CancelRequestCubit(requestsUseCase: RequestsUseCase(repository: RequestsRepositoriesImp(requestsRemoteDataSource: RequestsApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => ActivitiesCubit(activitiesUseCase: ActivitiesUseCase(repository: ActivitiesRepositoriesImp(activitiesRemoteDataSource: ActivitiesApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => NotificationDeleteCubit(notificationUseCase: NotificationUseCase(repository: NotificationRepositoryImpl(
            localDataSource: hiveNotificationDataSource,
            notificationRemoteDataSource: NotificationApiDataSource(dio, authHiveDataSource)))),),
        BlocProvider(create: (context) => DonationHistoryCubit(DonationHistoryUseCase(repository: DonationHistoryRepositoriesImp(remoteDataSource: DonationHistoryApiDataSource(dio, authHiveDataSource)))),)
      ],
      child: const BloodDonationApp(),
    ),
  );
}
