import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class CreatedHospitalSummary {
  const CreatedHospitalSummary({
    required this.hospitalName,
    required this.hospitalCode,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  final String hospitalName;
  final String hospitalCode;
  final String email;
  final String password;
  final String phone;
  final String address;

  String toShareText(AppLocalizations loc) {
    final buffer = StringBuffer()
      ..writeln(loc.hospitalAddedSuccessfully)
      ..writeln()
      ..writeln('${loc.hospitalName}: $hospitalName')
      ..writeln('${loc.hospital_id}: $hospitalCode')
      ..writeln('${loc.email}: $email')
      ..writeln('${loc.secure_password}: $password')
      ..writeln('${loc.phone}: $phone');
    if (address.isNotEmpty) {
      buffer.writeln('${loc.address}: $address');
    }
    return buffer.toString();
  }
}


class HospitalCreatedSuccessView extends StatelessWidget {
  const HospitalCreatedSuccessView({
    super.key,
    required this.summary,
    required this.onDone,
  });

  final CreatedHospitalSummary summary;
  final VoidCallback onDone;

  Future<void> _onShare(BuildContext context, AppLocalizations loc) async {
    final box = context.findRenderObject() as RenderBox?;
    final origin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;

    await SharePlus.instance.share(
      ShareParams(
        text: summary.toShareText(loc),
        subject: loc.addHospital,
        sharePositionOrigin: origin,
      ),
    );
  }

  Future<void> _onCopy(BuildContext context, AppLocalizations loc) async {
    await Clipboard.setData(ClipboardData(text: summary.toShareText(loc)));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(loc.copiedToClipboard),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: ColorManger.successBackground,
        ),
      );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: CustomText(
              text: label,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,

              ),
            ),
          ),
          Expanded(
            child: CustomText(
              text: value,
              textStyle: TextStyle(
                  fontWeight: FontWeightManager.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: ColorManger.successBackground,
          child: Icon(
            Icons.check_circle,
            color: ColorManger.successColor,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        CustomText(
          text: loc.hospitalAddedSuccessfully,
          textStyle: TextStyle(
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s18,
          ),

        ),
        const SizedBox(height: 4),
        CustomText(
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
          ),
          text: loc.addHospitalSubtitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Flexible(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: ColorManger.lightGrey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow(loc.hospitalName, summary.hospitalName),
                  _detailRow(loc.hospital_id, summary.hospitalCode),
                  _detailRow(loc.email, summary.email),
                  _detailRow(loc.secure_password, summary.password),
                  _detailRow(loc.phone, summary.phone),
                  if (summary.address.isNotEmpty)
                    _detailRow(loc.address, summary.address),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: ColorManger.slateGrey.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                ),
                onPressed: () => _onCopy(context, loc),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.copy_rounded, size: 18),
                    const SizedBox(width: 8),
                    CustomText(text: loc.copy),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomElevatedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: ColorManger.royalBlue.withValues(alpha: 0.45),
                    width: 1,
                  ),
                ),
                backgroundColor: ColorManger.royalBlue,
                foregroundColor: ColorManger.pureWhite,
                onPressed: () => _onShare(context, loc),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share_rounded, size: 18),
                    const SizedBox(width: 8),
                    CustomText(text: loc.share),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: onDone,
            child: CustomText(
                text: loc.done,
                textStyle: TextStyle(
                  color: ColorManger.royalBlue,
                  fontWeight: FontWeightManager.bold,
                )
            ),
          ),
        ),
      ],
    );
  }
}