import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class DonationTypePicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;

  const DonationTypePicker({
    super.key,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  State<DonationTypePicker> createState() => _DonationTypePickerState();
}

class _DonationTypePickerState extends State<DonationTypePicker> {
  String? selectTypeBlood;

  @override
  void initState() {
    super.initState();
    selectTypeBlood = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<String> donationSlots = [
      appLocalizations.wholeBlood,
      appLocalizations.plasma,
      appLocalizations.platelets,
      appLocalizations.doubleRedCells,
    ];

    return CustomDropDownButtonFormField(items: donationSlots, hintText: appLocalizations.chooseBloodType,
     onChanged: (value) {
      setState(() {
        selectTypeBlood = value;
      });
      widget.onChanged(value!);
    },
      initialValue: selectTypeBlood,
    );
  }
}



