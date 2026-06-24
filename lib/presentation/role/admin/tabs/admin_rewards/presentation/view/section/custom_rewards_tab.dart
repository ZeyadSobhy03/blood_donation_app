import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';

class CustomRewardsTab extends StatefulWidget {
  const CustomRewardsTab({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<CustomRewardsTab> createState() => _CustomRewardsTabState();
}

class _CustomRewardsTabState extends State<CustomRewardsTab> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant CustomRewardsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _selectedIndex = widget.initialIndex;
    }
  }

  void _onTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final isSelected = index == _selectedIndex;

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorManger.brightPurple.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: widget.tabs[index],
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: isSelected
                        ? FontWeightManager.bold
                        : FontWeightManager.regular,
                    color: isSelected
                        ? ColorManger.brightPurple
                        : ColorManger.slateGrey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}