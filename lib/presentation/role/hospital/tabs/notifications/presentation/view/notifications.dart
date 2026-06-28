import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/utils/notification_helper.dart';
import '../../../../../../../core/widgets/states/custom_error_widget.dart';
import '../../../../../../../core/widgets/states/custom_loading_widget.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_hive_data_source.dart';
import '../../data/models/notification/notifications_model.dart' as notif_model;
import '../view/widgets/mark_all_as_read_button.dart';
import '../view/widgets/notification_request.dart';
import '../view/widgets/title.dart';
import '../view_model/notification/notification_view_model.dart';

class HospitalNotifications extends StatefulWidget {
  const HospitalNotifications({super.key});

  @override
  State<HospitalNotifications> createState() => _HospitalNotificationsState();
}

class _HospitalNotificationsState extends State<HospitalNotifications> {
  List<notif_model.NotificationItem> _cachedNotifications = [];
  int _cachedUnreadCount = 0;
  bool _hasNextPage = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchNotifications(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  HospitalHiveDataSource get _dataSource =>
      RepositoryProvider.of<HospitalHiveDataSource>(context);

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchNotifications();
    }
  }

  Future<void> _fetchNotifications({bool isRefresh = false}) async {
    final token = await _dataSource.getAccessToken();
    if (token == null) return;
    if (context.mounted) {
      context.read<NotificationCubit>().fetchNotifications(
        accessToken: token,
        isRefresh: isRefresh,
      );
    }
  }

  String _getNotificationTitle(notif_model.NotificationItem item, AppLocalizations loc) {
    final r = item.dataRaw;
    switch (item.type) {
      case 'milestone':
      case 'achievement':
        return loc.notifications_milestone_title(r?['achievementTitle'] ?? '');
      case 'reward_tier_upgraded':
        return loc.notifications_rewards_tier_upgraded(r?['newTier'] ?? '');
      case 'reward_badge_unlocked':
        return loc.notifications_rewards_badge_unlocked(r?['badgeName'] ?? '');
      case 'reward_redeemed':
        return loc.notifications_rewards_reward_redeemed;
      case 'appointment_rescheduled':
        return loc.notifications_appointment_rescheduled;
      case 'appointment_donor_rescheduled':
        return loc.notifications_appointment_donor_rescheduled;
      case 'activity_tier_promoted':
        return loc.notifications_activity_tier_promoted;
      case 'activity_badge_unlocked':
        return loc.notifications_activity_badge_unlocked;
      case 'activity_redeemed_reward':
        return loc.notifications_activity_redeemed_reward;
      case 'activity_donation_created':
        return loc.notifications_activity_donation_created;
      case 'activity_donation_verified':
        return loc.notifications_activity_donation_verified;
      case 'activity_donation_confirmed':
        return loc.notifications_activity_donation_confirmed;
      case 'activity_donation_completed':
        return loc.notifications_activity_donation_completed;
      case 'activity_donation_cancelled':
        return loc.notifications_activity_donation_cancelled;
      case 'activity_blood_donation_submitted':
        return loc.notifications_activity_blood_donation_submitted;
      case 'activity_request_cancelled':
        return loc.notifications_activity_request_cancelled;
      case 'activity_request_rejected':
        return loc.notifications_activity_request_rejected;
      case 'admin_registrations_rising':
        return loc.notifications_admin_registrations_rising;
      case 'admin_registrations_declining':
        return loc.notifications_admin_registrations_declining;
      case 'admin_verification_gap':
        return loc.notifications_admin_verification_gap;
      case 'admin_inactive_hospitals':
        return loc.notifications_admin_inactive_hospitals;
      case 'admin_donor_retention_alert':
        return loc.notifications_admin_donor_retention_alert;
      case 'admin_suspension_spike':
        return loc.notifications_admin_suspension_spike;
      case 'admin_urgent_blood_request':
        return loc.notifications_admin_urgent_blood_request;
      case 'analytics_critical_need':
        return loc.notifications_analytics_critical_need_title(r?['bloodTypes'] ?? '');
      case 'analytics_predicted_high_demand':
        return loc.notifications_analytics_predicted_high_demand_title;
      case 'analytics_rising_demand':
        return loc.notifications_analytics_rising_demand_title;
      case 'analytics_declining_demand':
        return loc.notifications_analytics_declining_demand_title;
      case 'analytics_shortage_risk':
        return loc.notifications_analytics_shortage_risk_title;
      case 'analytics_supply_warning':
        return loc.notifications_analytics_supply_warning_title;
      case 'analytics_peak_day':
        return loc.notifications_analytics_peak_day_title;
      case 'analytics_retention_alert':
        return loc.notifications_admin_donor_retention_alert;
      case 'analytics_growth_positive':
        return loc.notifications_analytics_growth_positive_title;
      case 'analytics_emergency_spike':
        return loc.notifications_analytics_emergency_spike_title;
      default:
        if (item.type == 'reward') {
          final sub = r?['rewardType'];
          if (sub == 'tier_upgraded') {
            return loc.notifications_rewards_tier_upgraded(r?['newTier'] ?? '');
          } else if (sub == 'badge_unlocked') {
            return loc.notifications_rewards_badge_unlocked(r?['badgeName'] ?? '');
          }
          return loc.notifications_rewards_reward_redeemed;
        }
        return NotificationHelper.getTitleFromFields(
          type: item.type,
          title: item.title,
          message: item.message,
          dataRaw: item.dataRaw,
          loc: loc,
        );
    }
  }

  String _getNotificationBody(notif_model.NotificationItem item, AppLocalizations loc) {
    final r = item.dataRaw;
    switch (item.type) {
      case 'milestone':
      case 'achievement':
        return loc.notifications_milestone_body(r?['achievementTitle'] ?? '');
      case 'analytics_critical_need':
        return item.message ?? '';
      case 'analytics_predicted_high_demand':
        return loc.notifications_analytics_predicted_high_demand_body(r?['percent'] ?? '');
      case 'analytics_shortage_risk':
        return loc.notifications_analytics_shortage_risk_body(r?['bloodType'] ?? '');
      case 'analytics_supply_warning':
        return loc.notifications_analytics_supply_warning_body(r?['bloodType'] ?? '');
      case 'analytics_peak_day':
        return loc.notifications_analytics_peak_day_body(r?['peakDay'] ?? '', r?['pct'] ?? '');
      case 'analytics_retention_alert':
        return loc.notifications_analytics_retention_alert_body;
      case 'analytics_growth_positive':
        return loc.notifications_analytics_growth_positive_body;
      case 'analytics_emergency_spike':
        return loc.notifications_analytics_emergency_spike_body;
      case 'analytics_rising_demand':
        return loc.notifications_analytics_rising_demand_body;
      case 'analytics_declining_demand':
        return loc.notifications_analytics_declining_demand_body;
      default:
        return NotificationHelper.getBodyFromFields(
          type: item.type,
          title: item.title,
          message: item.message,
          dataRaw: item.dataRaw,
          loc: loc,
        );
    }
  }

  void _updateCachedData(NotificationState state) {
    if (state is NotificationSuccessState) {
      _cachedNotifications = state.notifications;
      _cachedUnreadCount = state.unreadCount;
      _hasNextPage = state.hasNextPage;
    } else if (state is NotificationPaginationLoadingState) {
      _cachedNotifications = state.notifications;
      _cachedUnreadCount = state.unreadCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        _updateCachedData(state);

        return Scaffold(
          backgroundColor: ColorManger.pureWhite,
          appBar: AppBar(
            backgroundColor: ColorManger.royalBlue,
            foregroundColor: ColorManger.pureWhite,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            title: TitleOfNotification(
              title: appLocalization.notifications_title,
              subTitle: appLocalization.notifications_unread(_cachedUnreadCount),
            ),
            actions: [
              BlocListener<NotificationDeleteCubit, NotificationDeleteState>(
                listener: (context, deleteState) {
                  if (deleteState is NotificationDeleteSuccessState) {
                    setState(() {
                      _cachedNotifications = [];
                      _cachedUnreadCount = 0;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(appLocalization.notifications_delete_success),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (deleteState is NotificationDeleteErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deleteState.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child:
                    BlocBuilder<NotificationDeleteCubit, NotificationDeleteState>(
                  builder: (context, deleteState) {
                    if (deleteState is NotificationDeleteLoadingState) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorManger.pureWhite,
                          ),
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: _cachedNotifications.isEmpty
                          ? null
                          : () => _showDeleteConfirmDialog(context, appLocalization),
                      icon: Icon(
                        Icons.delete_outline,
                        color: _cachedNotifications.isEmpty
                            ? ColorManger.pureWhite.withValues(alpha: 0.4)
                            : ColorManger.pureWhite,
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: SafeArea(
            child: _buildBody(context, state, appLocalization, _cachedNotifications),
          ),
          bottomNavigationBar: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BlocListener<NotificationAllReadCubit, NotificationAllReadState>(
                  listener: (context, allReadState) {
                    if (allReadState is NotificationAllReadSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(appLocalization.mark_all_as_read),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _fetchNotifications(isRefresh: true);
                    } else if (allReadState is NotificationAllReadErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(allReadState.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: MarkAllAsReadButton(
                    text: appLocalization.mark_all_as_read,
                    onPressed:
                        _cachedUnreadCount == 0 || _cachedNotifications.isEmpty
                        ? null
                        : () async {
                            final token = await _dataSource.getAccessToken();
                            if (token != null && context.mounted) {
                              context.read<NotificationAllReadCubit>().markAllAsRead(
                                accessToken: token,
                              );
                            }
                          },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, AppLocalizations appLocalization) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(appLocalization.notifications_delete_all),
        content: Text(
          appLocalization.notifications_delete_confirm,
          style: TextStyle(color: ColorManger.black.withValues(alpha: 0.6)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              appLocalization.cancel,
              style: TextStyle(color: ColorManger.black.withValues(alpha: 0.6)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final token = await _dataSource.getAccessToken();
              if (token != null && context.mounted) {
                context.read<NotificationDeleteCubit>().deleteNotifications(
                  accessToken: token,
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(appLocalization.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    NotificationState state,
    AppLocalizations appLocalization,
    List<notif_model.NotificationItem> notificationItems,
  ) {
    if (state is NotificationLoadingState && notificationItems.isEmpty) {
      return const CustomLoadingWidget();
    }

    if (state is NotificationErrorState && notificationItems.isEmpty) {
      return CustomErrorWidget(
        message: state.message,
        onRetry: () => _fetchNotifications(isRefresh: true),
      );
    }

    if (notificationItems.isEmpty) {
      return Center(child: Text(appLocalization.notifications_empty));
    }

    final bool isLoadingMore = state is NotificationPaginationLoadingState;

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          itemCount: notificationItems.length + (isLoadingMore || _hasNextPage ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == notificationItems.length) {
              return isLoadingMore
                  ? Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(color: ColorManger.royalBlue),
                      ),
                    )
                  : const SizedBox.shrink();
            }

            final item = notificationItems[index];
            final String type = item.type ?? 'info';

            return NotificationRequest(
              bloodRequest: type == 'emergency',
              isEmergency: type == 'emergency',
              icon: NotificationHelper.getIcon(type),
              iconColor: NotificationHelper.getIconColor(type),
              notification: item,
              titleOverride: _getNotificationTitle(item, appLocalization),
              bodyOverride: _getNotificationBody(item, appLocalization),
              onPressed: null,
            );
          },
        ),
        if (state is NotificationLoadingState)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(color: ColorManger.royalBlue),
          ),
      ],
    );
  }
}
