import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';

class QuestionTile extends StatefulWidget {
  const QuestionTile({super.key, required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  State<QuestionTile> createState() => _QuestionTileState();
}

class _QuestionTileState extends State<QuestionTile>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                text: widget.question,
                textStyle: TextStyle(
                  color: ColorManger.black,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.info_outline,
                  color: isExpanded ? ColorManger.brightRed : ColorManger.black,
                ),
              ),
            ),
          ],
        ),

        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: CustomText(
                    text: widget.answer,
                    textStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
