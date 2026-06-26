import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'l10n/app_localizations.dart';
import 'blocs/language/language_bloc.dart';

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,

            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteManger.router,
            initialRoute: RouteManger.splashScreen,
          );
        },
      ),
    );
  }
}