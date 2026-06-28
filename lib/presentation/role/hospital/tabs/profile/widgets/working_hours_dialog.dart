import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import 'labeled_dropdown.dart';
import 'stepper_button.dart';

class WorkingHoursDialog extends StatefulWidget {
  final int initialOpeningHour;
  final int initialClosingHour;
  final int initialSlotsPerHour;
  final void Function({
    required int openingHour,
    required int closingHour,
    required int slotsPerHour,
  }) onSave;

  const WorkingHoursDialog({
    super.key,
    required this.initialOpeningHour,
    required this.initialClosingHour,
    required this.initialSlotsPerHour,
    required this.onSave,
  });

  @override
  State<WorkingHoursDialog> createState() => _WorkingHoursDialogState();
}

class _WorkingHoursDialogState extends State<WorkingHoursDialog> {
  late int _openingHour;
  late int _closingHour;
  late int _slotsPerHour;

  @override
  void initState() {
    super.initState();
    _openingHour = widget.initialOpeningHour;
    _closingHour = widget.initialClosingHour;
    _slotsPerHour = widget.initialSlotsPerHour;
  }

  int get _hoursPerDay =>
      _closingHour > _openingHour ? _closingHour - _openingHour : 0;
  int get _totalDailySlots => _hoursPerDay * _slotsPerHour;

  String _fmt(int h) => '${h.toString().padLeft(2, '0')}:00';

  List<DropdownMenuItem<int>> _timeItems() => List.generate(
    24,
        (i) => DropdownMenuItem(value: i, child: Text(_fmt(i))),
  );

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${loc.manage_working_hours} &\n${loc.appointment_slots}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              loc.working_hours_subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                  children: [
                    TextSpan(
                      text: loc.working_hours_tip,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: loc.working_hours_tip_text,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: LabeledDropdown(
                    label: loc.opening_time,
                    value: _openingHour,
                    items: _timeItems(),
                    onChanged: (v) {
                      if (v != null) setState(() => _openingHour = v);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LabeledDropdown(
                    label: loc.closing_time,
                    value: _closingHour,
                    items: _timeItems(),
                    onChanged: (v) {
                      if (v != null) setState(() => _closingHour = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

             Text(
              loc.slots_per_hour,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                StepperButton(
                  label: "−",
                  onTap: () {
                    if (_slotsPerHour > 1) setState(() => _slotsPerHour--);
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _slotsPerHour.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                StepperButton(
                  label: "+",
                  onTap: () => setState(() => _slotsPerHour++),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              loc.slots_per_hour_text,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.summary,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${loc.operating_hours} ${_fmt(_openingHour)} - ${_fmt(_closingHour)}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "${loc.hours_per_day} $_hoursPerDay ${loc.measure_in_hours}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "${loc.slots_per_hour} $_slotsPerHour",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${loc.total_daily_capacity} $_totalDailySlots ${loc.slots}",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(loc.cancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSave(
                        openingHour: _openingHour,
                        closingHour: _closingHour,
                        slotsPerHour: _slotsPerHour,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(loc.saveChanges),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
