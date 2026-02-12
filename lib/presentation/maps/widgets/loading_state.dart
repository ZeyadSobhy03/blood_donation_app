import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/fonts/font_manger.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../l10n/app_localizations.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorManger.brightRed.withValues(alpha: 0.1), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorManger.brightRed),
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            CustomText(
              text: localizations.loadingMap,
              textStyle: TextStyle(
                color: ColorManger.brightRed,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
