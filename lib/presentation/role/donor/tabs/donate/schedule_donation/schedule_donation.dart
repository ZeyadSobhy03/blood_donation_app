import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/section/schedule_linear_progress_indicator.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/section/schedule_upper_title.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/steps/appointment_confirmed.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/steps/confirm_your_details.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/steps/date_time_step.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/steps/location_step.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/steps/review_and_confirm.dart';
import 'package:flutter/material.dart';

class ScheduleDonation extends StatefulWidget {
  const ScheduleDonation({super.key});

  @override
  State<ScheduleDonation> createState() => _ScheduleDonationState();
}

class _ScheduleDonationState extends State<ScheduleDonation> {
  final PageController _pageController = PageController();
  int currentStep = 0;
  int totalSteps = 5;

  void _nextStep() {
    if (currentStep < totalSteps - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.pureWhite,
        leading: IconButton(
          onPressed: _previousStep,
          icon: Icon(Icons.arrow_back),
        ),
        titleSpacing: 0,
        title: ScheduleUpperTitle(
          currentStep: currentStep,
          totalSteps: totalSteps,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ScheduleLinearProgressIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentStep = value;
                  });
                },
                children: [
                  LocationStep(nextStep: _nextStep),
                  DateTimeStep(next: _nextStep),
                  ConfirmYourDetails(nextStep: _nextStep),
                  ReviewAndConfirm(next: _nextStep),
                  AppointmentConfirmed(next: (){

                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
