import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/models/blood_request.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_stat_card.dart';
import 'package:flutter/material.dart';

import '../../../hospital/tabs/find_donor/widgets/hospital_title.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<BloodRequestModel> requests = [
      BloodRequestModel(
        bloodType: 'O+',
        unitsRequested: 3,
        urgencyLevel: 'critical',
        donorsContacted: 12,
        donorsConfirmed: 3,
        isFulfilled: false,
        requestDate: DateTime.now().subtract(const Duration(hours: 1)),
        completionTimeInHours: 2,
        priority: RequestPriority.high,
        location: appLocalizations.downTown,
        hospitalContact: '+20 100 111 2233',
        hospitalName: 'City Hospital',
      ),
      BloodRequestModel(
        bloodType: 'A-',
        unitsRequested: 2,
        urgencyLevel: 'high',
        donorsContacted: 8,
        donorsConfirmed: 2,
        isFulfilled: false,
        requestDate: DateTime.now().subtract(const Duration(hours: 2)),
        completionTimeInHours: 5,
        priority: RequestPriority.high,
        location: appLocalizations.westSide,
        hospitalContact: '+20 100 333 4455',
        hospitalName: 'Metro General',
      ),
      BloodRequestModel(
        bloodType: 'B+',
        unitsRequested: 4,
        urgencyLevel: 'critical',
        donorsContacted: 15,
        donorsConfirmed: 4,
        isFulfilled: false,
        requestDate: DateTime.now().subtract(const Duration(minutes: 40)),
        completionTimeInHours: 1,
        priority: RequestPriority.high,
        location: appLocalizations.eastSide,
        hospitalContact: '+20 100 555 6677',
        hospitalName: 'Regional Medical',
      ),
    ];
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: appLocalizations.bloodRequestsTitle,
                subTitle: appLocalizations.bloodRequestsSubtitle,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomStatCard(
                      icon: Icons.warning_amber_rounded,
                      count: "7",
                      label: appLocalizations.critical,
                      bgColor: ColorManger.lightRed,
                      iconColor: ColorManger.brightRed,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomStatCard(
                      icon: Icons.check_circle_outline,
                      count: "156",
                      label: appLocalizations.fulfilledToday,
                      bgColor: ColorManger.lightGreen,
                      iconColor: ColorManger.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              CustomText(
                text: appLocalizations.activeRequests,
                textStyle: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManger.black,
                ),
              ),
              const SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == requests.length - 1 ? 0 : 16,
                    ),
                    child: CustomRequestCard(request: request),
                  );
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  String getBadgeLabel({
    required String urgencyLevel,
    required AppLocalizations appLocalizations,
  }) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return appLocalizations.critical;
      case 'high':
        return appLocalizations.high;
      default:
        return appLocalizations.low;
    }
  }

  Color getBadgeColor(String urgencyLevel) {
    switch (urgencyLevel.toLowerCase()) {
      case 'critical':
        return ColorManger.brightRed;
      case 'high':
        return ColorManger.orange;

      default:
        return ColorManger.green;
    }
  }
}
