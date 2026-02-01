import 'package:blood_donation_app/presentation/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class RouteManger {
  static const String onboarding = '/onboarding';

  static Route router(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => OnboardingPage());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Center(child: Text('page not found')));
          },
        );
    }
  }
}
