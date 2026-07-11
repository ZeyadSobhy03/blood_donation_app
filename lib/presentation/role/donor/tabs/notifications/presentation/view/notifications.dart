
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view/widgets/mark_all_as_read_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view/widgets/notification_request.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view/widgets/title.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/presentation/view_model/notification/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/data/models/notification/notifications_model.dart'
as notification_model;

import '../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../core/utils/notification_helper.dart';
import '../../../../../../../core/widgets/states/custom_loading_widget.dart';
import '../../../home/presentation/view/bottom_sheet/confirm_response_bottom_sheet.dart';
import '../../../home/presentation/view_model/requests/requests_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/data/model/requests/requests_model.dart' as request_model;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<notification_model.Notifications> _cachedNotifications = [];
  int _cachedUnreadCount = 0;
  bool _hasNextPage = false;
  bool _isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications(isRefresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200 &&
        _hasNextPage &&
        !_isFetching) {
      context.read<NotificationCubit>().fetchNotifications();
    }
  }

  void _updateCachedData(NotificationState state) {
    if (state is NotificationSuccessState) {
      _cachedNotifications = state.notifications;
      _cachedUnreadCount = state.unreadCount;
      _hasNextPage = state.hasNextPage;
      _isFetching = false;
    } else if (state is NotificationPaginationLoadingState) {
      _cachedNotifications = state.notifications;
      _cachedUnreadCount = state.unreadCount;
      _isFetching = true;
    } else if (state is NotificationLoadingState) {
      _isFetching = true;
    } else if (state is NotificationErrorState) {
      _isFetching = false;
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
            backgroundColor: ColorManger.brightRed,
            foregroundColor: ColorManger.pureWhite,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            title: TitleOfNotification(
              title: appLocalization.notifications_title,
              subTitle: appLocalization.notifications_unread(
                _cachedUnreadCount,
              ),
            ),
            actions: [
              BlocListener<NotificationDeleteCubit, NotificationDeleteState>(
                listener: (context, deleteState) {
                  if (deleteState is NotificationDeleteSuccessState) {
                    setState(() {
                      _cachedNotifications = [];
                      _cachedUnreadCount = 0;
                      _hasNextPage = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(deleteState.message),
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
                BlocBuilder<
                    NotificationDeleteCubit,
                    NotificationDeleteState
                >(
                  builder: (context, deleteState) {
                    if (deleteState is NotificationDeleteLoadingState) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Skeletonizer(
                            enabled: true,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorManger.pureWhite,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: _cachedNotifications.isEmpty
                          ? null
                          : () => _showDeleteConfirmDialog(
                        context,
                        appLocalization,
                      ),
                      icon: Icon(
                        Icons.delete_outline,
                        color: _cachedNotifications.isEmpty
                            ? ColorManger.pureWhite.withValues(alpha: 0.4)
                            : ColorManger.pureWhite,
                      ),
                      tooltip: 'Delete all notifications',
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
            child: _buildBody(
              context,
              state,
              appLocalization,
              _cachedNotifications,
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BlocListener<
                    NotificationAllReadCubit,
                    NotificationAllReadState
                >(
                  listener: (context, allReadState) {
                    if (allReadState is NotificationAllReadSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(appLocalization.mark_all_as_read),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.read<NotificationCubit>().fetchNotifications(
                        isRefresh: true,
                      );
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
                        : () {
                      context
                          .read<NotificationAllReadCubit>()
                          .markAllAsRead();
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

  void _showDeleteConfirmDialog(
      BuildContext context,
      AppLocalizations appLocalization,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(appLocalization.delete_all_notifications_title),
        content: Text(
          appLocalization.delete_all_notifications_message,
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
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<NotificationDeleteCubit>().deleteNotifications();
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
      List<notification_model.Notifications> notificationItems,
      ) {
    if (state is NotificationLoadingState && notificationItems.isEmpty) {
      return const CustomLoadingWidget(
        indicatorColor: ColorManger.brightRed,
      );
    }

    if (state is NotificationErrorState && notificationItems.isEmpty) {
      return CustomErrorWidget(
        message: localizeError(state.message, appLocalization),
        onRetry: () {
          context.read<NotificationCubit>().fetchNotifications(isRefresh: true);
        },
      );
    }

    if (notificationItems.isEmpty) {
      return Center(child: Text(appLocalization.no_notifications));
    }

    final bool isLoadingMore = state is NotificationPaginationLoadingState;

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          itemCount: notificationItems.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {

            if (index == notificationItems.length) {
              return isLoadingMore
                  ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorManger.brightRed,
                  ),
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
              titleOverride: NotificationHelper.getTitle(item, appLocalization),
              bodyOverride: NotificationHelper.getBody(item, appLocalization),
              onPressed: type == 'emergency'
                  ? () async {
                final requestId = item.data?.requestId;
                if (requestId == null) return;

                final requestById = await context
                    .read<RequestsCubit>()
                    .fetchRequestById(requestId: requestId);
                final request= request_model.Request(

                  requestId: requestById?.data?.requestId,
                  createdAt: requestById?.data?.createdAt,
                  hospital: request_model.Hospital(
                    name: requestById?.data?.hospitalName,
                    contactNumber: requestById?.data?.hospitalContact,
                    address: request_model.Address(
                      raw: requestById?.data?.hospital?.address?.toString(),
                    ),
                  ),
                  hospitalName: requestById?.data?.hospitalName,
                  distanceKm: requestById?.data?.distanceKm,
                  bloodType: requestById?.data?.bloodType,
                  unitsNeeded: requestById?.data?.unitsNeeded,
                  isEmergency: requestById?.data?.isEmergency,
                  contactNumber: requestById?.data?.contactNumber,
                  hospitalContact: requestById?.data?.hospitalContact,

                );

                if (context.mounted) {
                  showConfirmResponseBottomSheet(context, request);
                }
              }
                  : null,
            );
          },
        ),

        if (state is NotificationLoadingState)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(color: ColorManger.brightRed),
          ),
      ],
    );
  }
}