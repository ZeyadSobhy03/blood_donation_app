import 'package:flutter/material.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../core/widgets/custom_text.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key, required this.nextStep, required this.text, required this.backgroundColor, required this.foregroundColor});
  final VoidCallback? nextStep;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context, constraints) {

      return  ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: constraints.maxWidth,
          minHeight: 50,
        ),
        child: CustomElevatedButton(
        elevation: 4,
        backgroundColor: nextStep==null? ColorManger.lightRed: backgroundColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        ),
        onPressed: nextStep,
        foregroundColor: foregroundColor,
        child: CustomText(text: text),
        ),
      );
    }
     ,
    );
  }
}
