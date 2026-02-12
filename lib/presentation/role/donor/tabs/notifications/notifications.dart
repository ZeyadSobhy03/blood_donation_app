import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/bottom_sheet/confirm_response_bottom_sheet.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/widgets/mark_all_as_read_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/widgets/notification_request.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/notifications/widgets/title.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/model/urgent_request.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/models/coordinates.dart';
import 'model/notification.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    // dummy data
    final List<NotificationModel> dummyNotifications = [
      NotificationModel(
        id: '1',
        title: 'Emergency Blood Request',
        subTitle: 'O+ blood urgently needed at City Hospital, 2.3 km away',
        time: '5 min ago',
        type: 'emergency',
        isRead: false,
        urgentRequest: UrgentRequestModel(
          createdAt: DateTime.now(),
          locationHospital: Coordinates(latitude: 30.0444, longitude: 31.2357),

          id: 'UR1',
          title: 'Emergency Blood Request',
          location: 'City Hospital, Nasr City',
          time: '5 min ago',
          isEmergency: true,
          bloodType: 'O+',
          unitsNeeded: 2,
          hospitalName: 'City Hospital',
          hospitalDistance: '2.3 km',
          patientType: 'Accident',
          contactNumber: '+201000000000',
        ),
      ),
      NotificationModel(
        id: '2',
        title: 'Profile Updated',
        subTitle: 'Your profile information has been updated successfully',
        time: '2 hours ago',
        type: 'info',
        isRead: true,
      ),
      NotificationModel(
        id: '3',
        title: 'Reward Earned',
        subTitle: 'You earned 100 points for donating blood',
        time: '1 day ago',
        type: 'reward',
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        title: 'Blood Donation Event',
        subTitle: 'Join us tomorrow at Central Hospital for a donation drive',
        time: '1 day ago',
        type: 'info',
        isRead: false,
      ),
      NotificationModel(
        id: '5',
        title: 'Achievement Unlocked',
        subTitle: 'You have donated blood 5 times! Keep it up!',
        time: '3 days ago',
        type: 'achievement',
        isRead: true,
      ),
    ];


    final unreadCount = dummyNotifications
        .where((notification) => !notification.isRead)
        .length;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.brightRed,
        foregroundColor: ColorManger.pureWhite,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: TitleOfNotification(
          title: appLocalization.notifications_title,
          subTitle: appLocalization.notifications_unread(unreadCount),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyNotifications.length,
        itemBuilder: (context, index) {
          final notification = dummyNotifications[index];
          IconData icon;
          Color iconColor;

          switch (notification.type) {
            case 'reward':
              icon = Icons.workspace_premium;
              iconColor = ColorManger.gold;
              break;
            case 'info':
              icon = Icons.access_time;
              iconColor = ColorManger.skyBlue;
              break;
            case 'achievement':
              icon = Icons.emoji_events;
              iconColor = ColorManger.brightRed;
              break;
            case 'emergency':
            default:
              icon = Icons.error_outline;
              iconColor = ColorManger.brightRed;
          }

          return NotificationRequest(
            bloodRequest: notification.type == 'emergency',
            isEmergency: notification.type == 'emergency',
            icon: icon,
            iconColor: iconColor,
            notification: notification,
            onPressed: () => showConfirmResponseBottomSheet(context, notification.urgentRequest!),
          );
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          return MarkAllAsReadButton(
            text: appLocalization.mark_all_as_read,
            onPressed: () {},
          );
        },
      ),
    );
  }
}
