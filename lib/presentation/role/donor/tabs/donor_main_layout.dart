import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view/donate.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/presentation/view/home.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/profile_main/profile.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'find_hospital/presentation/view/find.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
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
        end: 1.3,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    // Animate first icon on start
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
    // Reset previous icon
    _iconControllers[currentIndex].reverse();
    // Animate new icon
    _iconControllers[index].forward();

    setState(() => currentIndex = index);

    // iOS-style: fast + spring feel
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
      const FindHospital(),
      const Donate(),
      const RewardsScreen(),
      const Profile(),
    ];

    final navItems = [
      (Icons.home_rounded, Icons.home_outlined, appLocalizations.home),
      (Icons.search_rounded, Icons.search_outlined, appLocalizations.find),
      (
        Icons.favorite_rounded,
        Icons.favorite_border_outlined,
        appLocalizations.donate,
      ),
      (
        Icons.military_tech_rounded,
        Icons.military_tech_outlined,
        appLocalizations.rewards,
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
                                    scale: animation,
                                    child: child,
                                  ),
                              child: Icon(
                                isSelected ? item.$1 : item.$2,
                                key: ValueKey(isSelected),
                                size: isSelected ? 28 : 24,
                                color: isSelected
                                    ? ColorManger.brightRed
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
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? ColorManger.brightRed
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
                              color: ColorManger.brightRed,
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
