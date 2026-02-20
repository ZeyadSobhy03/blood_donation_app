import 'package:blood_donation_app/presentation/role/hospital/tabs/find_donor/find_donor.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/history/history.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/home.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/profile/profile.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/request/request.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/colors/color_manger.dart';
import '../../../../l10n/app_localizations.dart';

class HospitalMainLayout extends StatefulWidget {
  const HospitalMainLayout({super.key});

  @override
  State<HospitalMainLayout> createState() => _HospitalMainLayoutState();
}

class _HospitalMainLayoutState extends State<HospitalMainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<Widget> tabs = [
      Home(),
      FindDonor(),
      Request(),
      History(),
      Profile(),
    ];
    return  Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: ColorManger.royalBlue,
        unselectedItemColor: ColorManger.slateGrey,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManger.pureWhite,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: appLocalizations.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: appLocalizations.find,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: appLocalizations.request,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: appLocalizations.history,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: appLocalizations.profile,
          ),
        ],
      ),
    );
  }
}
