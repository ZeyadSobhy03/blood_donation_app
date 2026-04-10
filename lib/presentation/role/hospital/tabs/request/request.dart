import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/widgets/hospital_title.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/request_details_card.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class Request extends StatelessWidget {
  const Request({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(
                  title: appLocalizations.create_request,
                  subTitle: appLocalizations.create_request_dec,
                ),
                SizedBox(height: 16),
                EmergencyRequestCard(),
                SizedBox(height: 16),
                RequestDetailsCard(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
