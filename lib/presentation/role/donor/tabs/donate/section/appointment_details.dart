import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/appointment_information_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/section/qr_code_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_note_card.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../schedule_donation/model/donation_booking_card.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late DonationBookingCardModel model;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is DonationBookingCardModel) {
      model = args;
    } else {
      throw Exception('Expected DonationBookingCardModel as argument');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final location = '${model.hospitalName} - ${model.hospitalDistance}';
    final formattedDate =
        '${model.date?.day}/${model.date?.month}/${model.date?.year}';
    final time = model.timeSlot;
    final donationType = model.donationType;
    final List<String> items = [
      appLocalization.appointmentPrepStep1,
      appLocalization.appointmentPrepStep2,
      appLocalization.appointmentPrepStep3,
      appLocalization.appointmentPrepStep4,
    ];
    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 6),
                  Column(
                    children: [
                      CustomText(
                        text: appLocalization.appointmentDetailsTitle,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      SizedBox(height: 4),
                      CustomText(
                        text: appLocalization.appointmentDetailsSubtitle,
                        textStyle: TextStyle(
                          color: ColorManger.slateGrey,
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManger.lightGreen,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: CustomText(
                        text: model.isConfirmed ?? false
                            ? appLocalization.confirmed
                            : appLocalization.pending,
                        textStyle: TextStyle(
                          color: ColorManger.black,
                          height: 1.4,
                          fontSize: FontSize.s15,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              AppointmentInformationCard(
                location: location,
                formattedDate: formattedDate,
                time: '$time',
                donationType: '$donationType',
              ),
              SizedBox(height: 16),
              QrCodeCard(qrToken: model.appointmentId ?? ''),
              SizedBox(height: 16),
              CustomNoteCard(
                title: appLocalization.important,
                items: items,
                textColor: ColorManger.skyBlue,
                cardColor: ColorManger.lightBlue,
                bulletColor: ColorManger.skyBlue,
                borderColor: ColorManger.skyBlue.withValues(alpha: 0.3),
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: ColorManger.pureWhite,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomText(text: appLocalization.backToDonations),
              ),
              SizedBox(height: 4),
              CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                onPressed: shareQrCode,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomText(text: appLocalization.shareQrCode),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void shareQrCode() {
    final appLocalization = AppLocalizations.of(context)!;
    final String message =
        '''
${appLocalization.bloodDonationAppointmentShare}

${appLocalization.hospitalLabel}: ${model.hospitalName}
${appLocalization.dateLabel}: ${model.date?.day}/${model.date?.month}/${model.date?.year}
${appLocalization.timeLabel}: ${model.timeSlot}

${appLocalization.qrTokenLabel}:
${model.appointmentId}
''';

    SharePlus.instance.share(
      ShareParams(
        text: message,
      ),
    );
  }
}
