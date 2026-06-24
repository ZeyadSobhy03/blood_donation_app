import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import '../../../../../../../../l10n/app_localizations.dart';

const kBloodBankOptions = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

class BloodBankSelector extends StatelessWidget {
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;

  const BloodBankSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: loc.bloodBanksAvailable),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: kBloodBankOptions.map((bloodType) {
            final isSelected = selected.contains(bloodType);
            return FilterChip(
              label: Text(bloodType),
              selected: isSelected,
              onSelected: (value) {
                final updated = Set<String>.from(selected);
                value ? updated.add(bloodType) : updated.remove(bloodType);
                onChanged(updated);
              },
              selectedColor: ColorManger.royalBlue.withValues(alpha: 0.15),
              checkmarkColor: ColorManger.royalBlue,
              labelStyle: TextStyle(
                color: isSelected ? ColorManger.royalBlue : ColorManger.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? ColorManger.royalBlue
                      : ColorManger.lightGrey,
                ),
              ),
              backgroundColor: ColorManger.pureWhite,
            );
          }).toList(),
        ),
      ],
    );
  }
}