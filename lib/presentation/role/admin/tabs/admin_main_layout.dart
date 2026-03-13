import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requets/admin_request.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/analytics/analytics.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/dashboard/dashboard.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/system_setting.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/users.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class AdminMainLayout extends StatefulWidget {
  const AdminMainLayout({super.key});

  @override
  State<AdminMainLayout> createState() => _AdminMainLayoutState();
}

class _AdminMainLayoutState extends State<AdminMainLayout>
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
        duration: const Duration(milliseconds: 250),
      ),
    );

    _iconScales = _iconControllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.25,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
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

    final tabs = const [
      Dashboard(),
      Users(),
      AdminRequest(),
      Analytics(),
      SystemSetting(),
    ];

    final navItems = [
      (
        Icons.dashboard_rounded,
        Icons.dashboard_outlined,
        appLocalizations.dashboard,
      ),
      (Icons.group_rounded, Icons.group_outlined, appLocalizations.users),
      (
        Icons.bloodtype_rounded,
        Icons.bloodtype_outlined,
        appLocalizations.requests,
      ),
      (
        Icons.bar_chart_rounded,
        Icons.bar_chart_outlined,
        appLocalizations.analytics,
      ),
      (
        Icons.settings_rounded,
        Icons.settings_outlined,
        appLocalizations.settings,
      ),
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
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70,
            child: Row(
              children: List.generate(navItems.length, (index) {
                final isSelected = currentIndex == index;
                final item = navItems[index];

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTapped(index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _iconScales[index],
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
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

                        const SizedBox(height: 4),

                        Text(
                          item.$3,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? ColorManger.brightRed
                                : ColorManger.slateGrey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
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
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
