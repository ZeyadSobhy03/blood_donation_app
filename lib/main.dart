import 'package:blood_donation_app/blood_donation_app.dart';
import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/core/interceptors/auth_interceptor.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/remote/admin_auth_api_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/repositories/admin_auth_repositories_imp.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/domain/use_case/admin_auth_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/presentation/view_model/admin_auth_view_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_api_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/repositories/auth_repositories_imp.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/data_source/remote/admin_requests_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/data/repositories/admin_requests_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/domain/use_case/admin_requests_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/presentation/view_model/admin_requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/data_source/admin_rewards_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/data/repositories/admin_rewards_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/domain/use_case/admin_rewards_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view_model/admin_rewards_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/data_source/remote/analytics_overview_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/data/repositories/analytics_overview_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/domain/use_case/analytics_overview_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/presentation/view_model/analytics_overview_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/data_source/remote/analytics/analytics_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/data/repositories/analytics/analytics_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/domain/use_case/analytics/analytics_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/presentation/view_model/analytics/analytics_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/audit_logs/audit_logs_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/change_password/admin_change_password_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/inbound_email/inbound_email_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/log_out/admin_log_out_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/profile/admin_profile_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/rote_admin_key/rote_admin_key_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/system_health/system_health_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/data_source/remote/system_maintenance/system_maintenance_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/admin_change_password/admin_change_password_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/audit_logs/audit_logs_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/inbound_email/inbound_email_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/log_out/admin_log_out_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/profile/admin_profile_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/rote_admin_key/rote_admin_key_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_health/system_health_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/data/repositories/system_maintenance/system_maintenance_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/admin_change_password/admin_change_password_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/audit_logs/audit_logs_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/inbound_email/inbound_email_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/log_out/admin_log_out_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/profile/admin_profile_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/rote_admin_key/rote_admin_key_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/system_health/system_health_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/domain/use_case/system_maintenance/system_maintenance_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/admin_change_password/admin_change_password_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/audit_logs/audit_logs_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/inbound_email/inbound_email_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/profile/admin_profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/rote_admin_key/rote_admin_key_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/system_health/system_health_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/system_maintenance/system_maintenance_view_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/data_source/remote/users_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/repositories/users_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/domain/use_case/users_use_case.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view_model/users_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/data_source/ask_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/data/repositories/ask_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/domain/use_case/ask_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/chat_bot/presentation/view_model/ask_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/accepted_requests/accepted_requests_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/data_source/appointments/appointments_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/accepted_requests/accepted_requests_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/repositories/appointments/appointments_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/domain/use_case/accepted_requests/accepted_requests_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/domain/use_case/appointments/appointments_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/cubit/donation_schedule.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/data/data_source/time_slots/time_slots_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/data/repositories/time_slots/time_slots_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/domain/use_cases/time_slots/time_slots_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/schedule_donation/presentation/view_model/time_slots/time_slots_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/accepted_requests/accepted_requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/appointments/appointments_view_model.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/data_source/donation_history_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/data/repositories/donation_history_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/domain/use_case/donation_history_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donation_history/presentation/view_model/donation_history_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/data_source/nearby_hospitals_api_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/data/repositories/nearby_hospitals_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/domain/use_case/nearby_hospitals_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find_hospital/presentation/view_model/nearby_hospitals_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/activities/activities_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donation_eligibility/donation_eligibility_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/local/hive_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/donor_states/remote/api_donor_states_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/data_source/requests/requests_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/activities/activities_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donation_eligibility/donation_eligibility_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/donor_states/donor_states_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/repositories/requests/requests_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/activities/activities_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donation_eligibility/donation_eligibility_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/donor_states/donor_states_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/domain/use_case/requests/requests_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/activities/activities_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view_model/donation_eligibility/donation_eligibility_view_model.dart';
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
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/change_password/change_password_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/profile/profile_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/setting/setting_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/data_source/remote/support_contact/support_contact_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/change_password/change_password_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/profile/profile_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/setting/setting_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/data/repositories/support_contact/support_contact_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/change_password/change_password_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/profile/profile_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/setting/setting_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/domain/use_case/support_contact/support_contact_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/data_source/edit_profile_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/data/repositories/edit_profile_repositories_imp.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/domain/use_case/edit_profile_use_case.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/change_password/change_password_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile/profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/setting/setting_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/support_contact/support_contact_view_model.dart';
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
import 'blocs/language/language_bloc.dart';
import 'firebase_options.dart';
import 'notifications.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);

  await Hive.openBox('app_settings');

  final authHiveDataSource = AuthHiveDataSource();
  await authHiveDataSource.init();

  final adminHiveDataSource = AdminHiveDataSource();
  await adminHiveDataSource.init();

  Dio dio = Dio();
  dio.interceptors.add(
    AuthInterceptor(hiveDataSource: authHiveDataSource, dio: dio),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final hiveDonorStatesDataSource = HiveDonorStatesDataSource();
  final hiveNotificationDataSource = HiveNotificationDataSource();
  await hiveNotificationDataSource.init();

  await hiveDonorStatesDataSource.init();
  await getFCMToken();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdminChangePasswordCubit(AdminChangePasswordUseCase(adminChangePasswordRepositories: AdminChangePasswordRepositoriesImp(remoteDataSource: AdminChangePasswordApiDataSource(dio, adminHiveDataSource))), authUseCase:AdminLogOutUseCase(logOutRepositories: AdminLogOutRepositoriesImp(remoteDataSource: AdminLogOutApiDataSource(dio, adminHiveDataSource))) , authLocalDataSource: adminHiveDataSource),),
        BlocProvider(
          create: (context) => LanguageBloc()..add(InitializeLanguageEvent()),
        ),
        BlocProvider(
          create: (context) => RoteAdminKeyCubit(
            roteAdminKeyUseCase: RoteAdminKeyUseCase(
              roteAdminKeyRepositories: RoteAdminKeyRepositoriesImp(
                roteAdminKeyRemoteDataSource: RoteAdminKeyApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuditLogsCubit(
            auditLogsUseCase: AuditLogsUseCase(
              auditLogsRepositories: AuditLogsRepositoriesImp(
                auditLogsRemoteDataSource: AuditLogsApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SystemMaintenanceCubit(
            systemMaintenanceUseCase: SystemMaintenanceUseCase(
              systemMaintenanceRepositories: SystemMaintenanceRepositoriesImp(
                systemMaintenanceRemoteDataSource:
                    SystemMaintenanceApiDataSource(dio, adminHiveDataSource),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AdminRewardsCubit(
            adminRewardsUseCase: AdminRewardsUseCase(
              adminRewardsRepositories: AdminRewardsRepositoriesImp(
                adminRewardsRemoteDataSource: AdminRewardsApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SupportContactCubit(
            supportContactUseCase: SupportContactUseCase(
              supportContactRepositories: SupportContactRepositoriesImp(
                supportContactRemoteDataSource: SupportContactApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AcceptedRequestsCubit(
            acceptedRequestsUseCase: AcceptedRequestsUseCase(
              acceptedRequestsRepositories: AcceptedRequestsRepositoriesImp(
                acceptedRequestsRemoteDataSource: AcceptedRequestsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => InboundEmailCubit(
            inboundEmailUseCase: InboundEmailUseCase(
              inboundEmailRepositories: InboundEmailRepositoriesImp(
                inboundEmailRemoteDataSource: InboundEmailApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => UsersCubit(
            usersUseCase: UsersUseCase(
              usersRepositories: UsersRepositoriesImp(
                usersRemoteDataSource: UsersApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AnalyticsOverviewCubit(
            analyticsOverviewUseCase: AnalyticsOverviewUseCase(
              analyticsOverviewRepositories: AnalyticsOverviewRepositoriesImp(
                analyticsOverviewRemoteDataSource:
                    AnalyticsOverviewApiDataSource(dio, adminHiveDataSource),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AdminRequestsCubit(
            adminRequestsUseCase: AdminRequestsUseCase(
              adminRequestsRepositories: AdminRequestsRepositoriesImp(
                adminRequestsRemoteDataSource: AdminRequestsApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AdminProfileCubit(
            adminProfileUseCase: AdminProfileUseCase(
              profileRepositories: AdminProfileRepositoriesImp(
                profileRemoteDataSource: AdminProfileApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AnalyticsCubit(
            analyticsUseCase: AnalyticsUseCase(
              analyticsRepositories: AnalyticsRepositoriesImp(
                analyticsRemoteDataSource: AnalyticsApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SystemHealthCubit(
            systemHealthUseCase: SystemHealthUseCase(
              systemHealthRepositories: SystemHealthRepositoriesImp(
                systemHealthRemoteDataSource: SystemHealthApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
          ),
        ),
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
                authRemoteDataSource: AuthApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
            authHiveDataSource: authHiveDataSource,
          ),
        ),
        BlocProvider(
          create: (context) => AdminAuthCubit(
            adminAuthUseCase: AdminAuthUseCase(
              adminAuthRepositories: AdminAuthRepositoriesImp(
                adminAuthRemoteDataSource: AdminAuthApiDataSource(
                  dio,
                  adminHiveDataSource,
                ),
              ),
            ),
            adminHiveDataSource: adminHiveDataSource,
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
        BlocProvider(
          create: (context) => NotificationAllReadCubit(
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
        BlocProvider(
          create: (context) => FcmCubit(
            fcmUseCase: FcmUseCase(
              repository: FcmRepositoriesImp(
                fcmRemoteDataSource: FcmApiDataSource(dio, authHiveDataSource),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => TimeSlotsCubit(
            timeSlotsUseCase: TimeSlotsUseCase(
              repository: TimeSlotsRepositoriesImp(
                remoteDataSource: TimeSlotsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SettingCubit(
            settingUseCase: SettingUseCase(
              settingRepositories: SettingRepositoriesImp(
                settingRemoteDataSource: SettingApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => EarningRulesCubit(
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
          create: (context) => UserPointsCubit(
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
          create: (context) => RequestsCubit(
            requestsUseCase: RequestsUseCase(
              repository: RequestsRepositoriesImp(
                requestsRemoteDataSource: RequestsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AcceptRequestCubit(
            requestsUseCase: RequestsUseCase(
              repository: RequestsRepositoriesImp(
                requestsRemoteDataSource: RequestsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CancelRequestCubit(
            requestsUseCase: RequestsUseCase(
              repository: RequestsRepositoriesImp(
                requestsRemoteDataSource: RequestsApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ActivitiesCubit(
            activitiesUseCase: ActivitiesUseCase(
              repository: ActivitiesRepositoriesImp(
                activitiesRemoteDataSource: ActivitiesApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => NotificationDeleteCubit(
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
        BlocProvider(
          create: (context) => DonationHistoryCubit(
            DonationHistoryUseCase(
              repository: DonationHistoryRepositoriesImp(
                remoteDataSource: DonationHistoryApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => EditProfileCubit(
            profileUseCase: EditProfileUseCase(
              repository: EditProfileRepositoriesImp(
                remoteDataSource: EditProfileApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(
            authUseCase: AuthUseCase(
              authRepositories: AuthRepositoriesImp(
                authRemoteDataSource: AuthApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
            authLocalDataSource: authHiveDataSource,
            ChangePasswordUseCase(
              repository: ChangePasswordRepositoriesImp(
                remoteDataSource: ChangePasswordApiDataSource(
                  dio,
                  authHiveDataSource,
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DonationEligibilityCubit(
            DonationEligibilityUseCase(
              repository: DonationEligibilityRepositoriesImp(
                remoteDataSource: DonationEligibilityApiDataSource(
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
  );
}
