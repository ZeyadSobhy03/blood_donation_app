import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import '../../core/resources/assets_manger/assets_manger.dart';
import '../../core/resources/colors/color_manger.dart';
import '../../core/resources/fonts/font_manger.dart';
import '../../core/resources/routes/route_manger.dart';
import '../../core/service/firebase_notification_service.dart';
import '../../core/widgets/custom_text.dart';
import '../role/hospital/tabs/notifications/presentation/view_model/fcm/fcm_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _logoSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.2, 0)).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 0.9, curve: Curves.easeInOutCubic),
          ),
        );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      final navigator = Navigator.of(context);
      final fcmCubit = context.read<FcmCubit>();

      try {
        final hospitalBox = await Hive.openBox('hospital_auth_box');
        final token = hospitalBox.get('hospital_access_token') as String?;
        final userData = hospitalBox.get('hospital_user_data');
        log('SplashCheck: hospital token=${token?.isNotEmpty == true}, userData=${userData != null}');

        if (token != null && token.isNotEmpty && userData != null) {
          await _refreshFcmToken(fcmCubit, token);
          if (!mounted) return;
          navigator.pushReplacementNamed(RouteManger.hospitalMainLayout);
          return;
        }

        final donorBox = await Hive.openBox('auth_box');
        final donorToken = donorBox.get('access_token') as String?;
        final donorUserData = donorBox.get('user_data');
        log('SplashCheck: donor token=${donorToken?.isNotEmpty == true}, userData=${donorUserData != null}');

        if (donorToken != null && donorToken.isNotEmpty && donorUserData != null) {
          if (!mounted) return;
          navigator.pushReplacementNamed(RouteManger.donorMainLayout);
          return;
        }
      } catch (e) {
        log('SplashCheck error: $e');
      }

      if (!mounted) return;
      log('SplashCheck: no session, navigating to chooseRole');
      navigator.pushReplacementNamed(RouteManger.chooseRole);
    });
  }

  Future<void> _refreshFcmToken(FcmCubit cubit, String token) async {
    try {
      final fcmToken = await FirebaseNotificationService.getFCMToken();
      if (fcmToken == null) return;
      cubit.saveFcmToken(
        token: fcmToken,
        accessToken: token,
      );
    } catch (_) {
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 60),
            
                SlideTransition(
                  position: _logoSlideAnimation,
                  child: FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: Image.asset(
                      AssetsManger.icon,
                      width: 220,
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(-115, 0),
                  child: ClipRect(
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: SlideTransition(
                        position: _textSlideAnimation,
                        child: CustomText(
                          text: 'LifeLink',
                          textStyle: TextStyle(
                            fontSize: FontSize.s32,
                            fontWeight: FontWeightManager.extraBold,
                            color: ColorManger.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
