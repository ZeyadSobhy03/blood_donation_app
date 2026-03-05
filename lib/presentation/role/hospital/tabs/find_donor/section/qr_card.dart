import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class QrCard extends StatefulWidget {
  final String donorId;
  const QrCard({super.key, required this.donorId});

  @override
  State<QrCard> createState() => _QrCardState();
}

class _QrCardState extends State<QrCard> {
  DateTime expiryTime = DateTime.now().add(const Duration(minutes: 5));
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCounter();
  }

  void startCounter() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (expiryTime.isBefore(DateTime.now())) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  String formatTime() {
    final remaining = expiryTime.difference(DateTime.now());

    if (remaining.isNegative) {
      return "00:00";
    }

    final minutes = remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManger.lightGrey, width: 1),
      ),
      elevation: 4,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: ColorManger.lightGrey,
                  width: 1,
                ),
              ),
              color: ColorManger.pureWhite,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    QrImageView(
                      data:
                      'https://example.com/donation/${widget.donorId}',
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  color: ColorManger.royalBlue,
                  size: 20,
                ),

                const SizedBox(width: 8),

                CustomText(
                  text: formatTime(),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.royalBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            CustomText(
              text: appLocalization.time_remaining,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
