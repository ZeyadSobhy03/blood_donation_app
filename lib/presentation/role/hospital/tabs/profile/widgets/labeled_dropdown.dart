import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class LabeledDropdown extends StatelessWidget {
  final String label;
  final int value;
  final List<DropdownMenuItem<int>> items;
  final ValueChanged<int?> onChanged;

  const LabeledDropdown({super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              dropdownColor: ColorManger.pureWhite,
              value: value,
              isExpanded: true,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}