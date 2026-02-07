import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/donate.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/find.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/home.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/profile.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    List<Widget> tabs = [Home(), Find(), Donate(), Rewards(), Profile()];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManger.brightRed,
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
            label: appLocalizations.donate,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.military_tech),
            label: appLocalizations.rewards,
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
