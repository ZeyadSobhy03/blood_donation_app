import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/request_detail_body.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class RequestDetailsCard extends StatefulWidget {
  const RequestDetailsCard({super.key});

  @override
  State<RequestDetailsCard> createState() => _RequestDetailsCardState();
}

class _RequestDetailsCardState extends State<RequestDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.pureWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: appLocalizations.requestDetails,
                textStyle: TextStyle(
                  fontSize: FontSize.s15,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.black,
                ),
              ),
              SizedBox(height: 16),
              RequestDetailBody(),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}
