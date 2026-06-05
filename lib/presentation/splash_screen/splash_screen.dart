import 'dart:developer';

import 'package:blood_donation_app/presentation/authentication/admin_authentication/presentation/view_model/admin_auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/resources/assets_manger/assets_manger.dart';
import '../../core/resources/colors/color_manger.dart';
import '../../core/resources/fonts/font_manger.dart';
import '../../core/resources/routes/route_manger.dart';
import '../../core/widgets/custom_text.dart';
import '../../presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';

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

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final authCubit = context.read<AuthCubit>();
      final adminCubit=context.read<AdminAuthCubit>();

      log('Checking if user is logged in...');
      final donorIsLoggedIn = await authCubit.isUserLoggedIn();
      final adminIsLoggedIn = await adminCubit.isAdminLoggedIn();
      log('Admin logged in: $adminIsLoggedIn');
      log('User logged in: $donorIsLoggedIn');

      if (donorIsLoggedIn || adminIsLoggedIn) {
        final donorRole = await authCubit.validateToken();
        final adminRole=await adminCubit.validateToken();
        final role = donorRole ?? adminRole;
        log('User role: $donorRole');
          log('Admin role: $adminRole');

        if (role != null) {
          if (role.toLowerCase() == 'admin') {
            await adminCubit.getMe();
          } else {
            await authCubit.getMe();
          }

          await Future.delayed(const Duration(seconds: 3));
          if (!mounted) return;
          _navigateByRole(role);
          return;
        } else {
          await Future.delayed(const Duration(seconds: 3));
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, RouteManger.chooseRole);
          return;
        }
      }

      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteManger.chooseRole);
    } catch (e) {
      log('Error during app initialization: $e');
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteManger.chooseRole);
    }
  }

  void _navigateByRole(String role) {
    log('Navigating by role: $role');
    switch (role.toLowerCase()) {
      case 'donor':
        Navigator.pushReplacementNamed(context, RouteManger.donorMainLayout);
        break;
      case 'hospital':
        Navigator.pushReplacementNamed(context, RouteManger.hospitalMainLayout);
        break;
      case 'admin':
        Navigator.pushReplacementNamed(context, RouteManger.adminMainLayout);
        break;
      default:
        log('Unknown role: $role → going to chooseRole');
        Navigator.pushReplacementNamed(context, RouteManger.chooseRole);
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
                const SizedBox(width: 60),
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
                  offset: const Offset(-115, 0),
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