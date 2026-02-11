import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/resources/assets_manger/assets_manger.dart';
import '../../core/resources/colors/color_manger.dart';
import '../../core/resources/fonts/font_manger.dart';
import '../../core/resources/routes/route_manger.dart';
import '../../core/widgets/custom_text.dart';

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

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteManger.chooseRole);
    });
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 60.w),

              SlideTransition(
                position: _logoSlideAnimation,
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: Image.asset(
                    AssetsManger.icon,
                    width: 220.w,
                    height: 180.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-115.w, 0),
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
    );
  }
}
