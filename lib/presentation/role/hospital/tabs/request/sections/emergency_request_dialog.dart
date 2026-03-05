import 'package:blood_donation_app/core/resources/colors/color_manger.dart';

import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/alerts_card.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_body.dart';

import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_header.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/sections/emergency_request_navigation_button.dart';
import 'package:flutter/material.dart';


class EmergencyRequestDialog extends StatefulWidget {
  const EmergencyRequestDialog({super.key});

  @override
  State<EmergencyRequestDialog> createState() => _EmergencyRequestDialogState();
}

class _EmergencyRequestDialogState extends State<EmergencyRequestDialog> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmergencyRequestHeader(),
                  SizedBox(height: 16),
                  AlertsCard(),
                  SizedBox(height: 16),
                  EmergencyRequestBody(),
                  SizedBox(height: 24),
                  EmergencyRequestNavigationButton(
                    onSubmit: () {},
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
