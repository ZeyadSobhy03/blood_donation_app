import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../blocs/language/language_bloc.dart';

class LanguageToggle extends StatelessWidget {
  final Color activeColor;

  const LanguageToggle({
    super.key,
    this.activeColor = ColorManger.brightRed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final isArabic = state.locale.languageCode == 'ar';
        final initialIndex = isArabic ? 0 : 1;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: ToggleSwitch(
              initialLabelIndex: initialIndex,
              totalSwitches: 2,
              labels: const ['العربية', 'English'],
              activeBgColor: [activeColor],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey.withOpacity(0.1),
              inactiveFgColor: Colors.grey[500],
              cornerRadius: 20.r,
              borderWidth: 1,
              borderColor: [Colors.grey.withOpacity(0.2)],
              iconSize: 8.sp,
              fontSize: 11.sp,
              minWidth: 80.w,
              minHeight: 35.h,
              onToggle: (index) {
                if (index == 0) {
                  context
                      .read<LanguageBloc>()
                      .add( ChangeLanguageEvent(languageCode: 'ar'));
                } else {
                  context
                      .read<LanguageBloc>()
                      .add( ChangeLanguageEvent(languageCode: 'en'));
                }
              },
            ),
          ),
        );
      },
    );
  }
}