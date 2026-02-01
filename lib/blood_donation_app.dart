import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteManger.router,
      initialRoute: RouteManger.onboarding,
    );
  }
}
