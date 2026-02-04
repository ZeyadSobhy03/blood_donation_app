import 'package:blood_donation_app/core/resources/colors/color_manger.dart';

import 'package:blood_donation_app/presentation/onboarding/model/onboarding_model.dart';
import 'package:blood_donation_app/presentation/onboarding/section/onboarding_navigation_buttons.dart';
import 'package:blood_donation_app/presentation/onboarding/section/onboarding_page_indicators.dart';
import 'package:blood_donation_app/presentation/onboarding/section/onboarding_page_item.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, required this.pages, required this.onDone});

  final List<OnboardingModel> pages;
  final VoidCallback onDone;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void _nextPage() {
    if (currentPage < widget.pages.length - 1) {
      pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      widget.onDone();
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      pageController.animateToPage(
        currentPage - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = widget.pages[currentPage];

    return Scaffold(
      backgroundColor: page.backgroundColor ?? ColorManger.softPinkishWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.pages.length,
                onPageChanged: (index) => setState(() => currentPage = index),
                itemBuilder: (context, index) {
                  return OnboardingPageItem(page: widget.pages[index]);
                },
              ),
            ),
            OnboardingPageIndicators(
              currentIndex: currentPage,
              total: widget.pages.length,
            ),
            OnboardingNavigationButtons(
              onNext: _nextPage,
              onBack: _previousPage,
              isFirst: currentPage == 0,
              isLast: currentPage == widget.pages.length - 1,
              onDone: widget.onDone,
            ),
          ],
        ),
      ),
    );
  }
}
