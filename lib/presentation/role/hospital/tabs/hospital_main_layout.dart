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

class _HospitalMainLayoutState extends State<HospitalMainLayout>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  late List<AnimationController> _iconControllers;
  late List<Animation<double>> _iconScales;

  @override
  void initState() {
    super.initState();

    _iconControllers = List.generate(
      5,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );

    _iconScales = _iconControllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.25,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    _iconControllers[0].forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var c in _iconControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    _iconControllers[currentIndex].reverse();
    _iconControllers[index].forward();

    setState(() => currentIndex = index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final tabs = [
      const Home(),
      const FindDonor(),
      const Request(),
      const History(),
      const Profile(),
    ];

    final navItems = [
      (Icons.home_rounded, Icons.home_outlined, appLocalizations.home),
      (Icons.search_rounded, Icons.search_outlined, appLocalizations.find),
      (
      Icons.favorite_rounded,
      Icons.favorite_border_outlined,
      appLocalizations.request,
      ),
      (
      Icons.assignment_rounded,
      Icons.assignment_outlined,
      appLocalizations.history,
      ),
      (Icons.person_rounded, Icons.person_outlined, appLocalizations.profile),
    ];

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,

      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          _iconControllers[currentIndex].reverse();
          _iconControllers[index].forward();
          setState(() => currentIndex = index);
        },
        children: tabs,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorManger.pureWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 72,
            child: Row(
              children: List.generate(navItems.length, (index) {
                final isSelected = currentIndex == index;
                final item = navItems[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTapped(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// ICON
                          ScaleTransition(
                            scale: _iconScales[index],
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                      scale: animation, child: child),
                              child: Icon(
                                isSelected ? item.$1 : item.$2,
                                key: ValueKey(isSelected),
                                size: isSelected ? 28 : 24,
                                color: isSelected
                                    ? ColorManger.royalBlue
                                    : ColorManger.slateGrey,
                              ),
                            ),
                          ),

                          const SizedBox(height: 2),

                          /// LABEL
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isSelected ? 12 : 11,
                              fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected
                                  ? ColorManger.royalBlue
                                  : ColorManger.slateGrey,
                            ),
                            child: Text(
                              item.$3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(height: 2),

                          /// INDICATOR
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            height: 3,
                            width: isSelected ? 18 : 0,
                            decoration: BoxDecoration(
                              color: ColorManger.royalBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}