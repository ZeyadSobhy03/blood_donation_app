import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/donation_status_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/section/upper_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UpperTitle(
                      title: 'Welcome back, Sarah!',
                      subTitle: 'Ready to save lives today?',
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: ColorManger.brightRed,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 4.h,),
                DonationStatusCard(
                  donationStatus: 'Eligible to donate',
                  bloodType: 'O+',
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
