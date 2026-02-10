import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/widgets/donation_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../schedule_donation/model/donation_booking_card.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    List<DonationBookingCardModel> bookingCards = [
      DonationBookingCardModel(
        date: DateTime.now(),
        donationType: 'Whole Blood',
        hospitalName: 'City Hospital',
        hospitalDistance: '5 km',
        isConfirmed: true,
        firstName: 'John',
        lastName: 'Doe',
        phone: '1234567890',
        email: 'john.doe@example.com',
        bloodType: 'A+',
        timeSlot: '10:00 AM - 11:00 AM',
        appointmentId: 'ABC123',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DonationBookingCardModel(
        date: DateTime.now(),
        donationType: 'Platelets',
        hospitalName: 'City Hospital',
        hospitalDistance: '5 km',
        isConfirmed: false,
        firstName: 'Jane',
        lastName: 'Doe',
        phone: '0987654321',
        email: 'jane.doe@example.com',
        bloodType: 'O+',
        timeSlot: '11:00 AM - 12:00 PM',
        appointmentId: 'XYZ789',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DonationBookingCardModel(
        timeSlot: '12:00 PM - 1:00 PM',
        date: DateTime.now(),
        donationType: 'Whole Blood',
        hospitalName: 'City Hospital',
        hospitalDistance: '5 km',
        isConfirmed: true,
        firstName: 'John',
        lastName: 'Doe',
        phone: '0123456789',
        email: 'john.doe@example.com',
        bloodType: 'A+',
        appointmentId: 'ABC123',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.upcomingAppointments,
              textStyle: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSize.s15,
                height: 1.4,
                color: ColorManger.black,
              ),
            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingCards.length,
              itemBuilder: (context, index) =>
                  DonationBookingCard(model: bookingCards[index]),
            ),
          ],
        ),
      ),
    );
  }
}
