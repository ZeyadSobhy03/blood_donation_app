
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../core/resources/colors/color_manger.dart';


class QrCard extends StatefulWidget {
  final String qrToken;
  const QrCard({super.key, required this.qrToken});

  @override
  State<QrCard> createState() => _QrCardState();
}

class _QrCardState extends State<QrCard> {





  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManger.brightRed, width: 1),
      ),
      elevation: 4,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            QrImageView(
              data:
              'https://example.com/donation/${widget.qrToken}',
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 16),


          ],
        ),
      ),
    );
  }
}
