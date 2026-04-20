import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/l10n/app_localizations_ar.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_request_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_requests/widgets/custom_stat_card.dart';
import 'package:flutter/material.dart';

class AdminRequest extends StatelessWidget {
  const AdminRequest({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizationsAr appLocalizations = AppLocalizationsAr();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             appLocalizations.bloodRequestsTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              appLocalizations.bloodRequestsSubtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------Top Statistics Row ------------
            Row(
              children: [
                Expanded(
                  child: CustomStatCard(
                    icon: Icons.warning_amber_rounded,
                    count: "7",
                    label: appLocalizations.critical,
                    bgColor: const Color(0xFFFFF5F5),
                    iconColor: const Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomStatCard(
                    icon: Icons.check_circle_outline,
                    count: "156",
                    label: appLocalizations.fulfilledToday,
                    bgColor: const Color(0xFFF0FDF4),
                    iconColor: const Color(0xFF22C55E),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ----------List Header--------------
            Text(
               appLocalizations.activeRequests,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // ------------Active Request Cards------------
            CustomRequestCard(
              title: "City Hospital - O+ Blood",
              badgeLabel: appLocalizations.critical,
              badgeColor: const Color(0xFFFF3B30),
              units: 3,
              timeString: appLocalizations.hours_left(2),
              location: appLocalizations.downTown,
              contacted: 12,
              confirmed: 3,
            ),
            const SizedBox(height: 16),
            CustomRequestCard(
              title: "Metro General - A- Blood",
              badgeLabel: appLocalizations.high,
              badgeColor: const Color(0xFFFF8C00),
              units: 2,
              timeString: appLocalizations.hours_left(5),
              location: appLocalizations.westSide,
              contacted: 8,
              confirmed: 2,
            ),
            const SizedBox(height: 16),
            CustomRequestCard(
              title: "Regional Medical - B+ Blood",
              badgeLabel: appLocalizations.critical,
              badgeColor: const Color(0xFFFF3B30),
              units: 4,
              timeString: appLocalizations.hours_left(1),
              location: appLocalizations.eastSide,
              contacted: 15,
              confirmed: 4,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}