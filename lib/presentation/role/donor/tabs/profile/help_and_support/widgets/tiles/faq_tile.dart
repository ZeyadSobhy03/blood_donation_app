import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqTile extends StatefulWidget {
  final String question;
  final String answer;

  const FaqTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurn;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _iconTurn = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: ColorManger.lightGrey),
        InkWell(
          onTap: _toggle,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    text: widget.question,
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontWeight: FontWeightManager.regular,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                RotationTransition(
                  turns: _iconTurn,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorManger.slateGrey,
                    size: 20.sp.clamp(18, 22),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1,
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: widget.answer,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSize.s13,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}