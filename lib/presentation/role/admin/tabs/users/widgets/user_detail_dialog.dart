import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/admin_action_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/summary_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/resources/models/user_model.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../hospital/tabs/find_donor/widgets/contact_tile.dart';
import '../../../../hospital/tabs/home/section/request_header.dart';

class UserDetailDialog extends StatelessWidget {
  const UserDetailDialog({super.key, required this.user});

  final UserModel user;

  Map<String, Color> _getColorsByRole() {
    switch (user.role) {
      case 'Donor':
        return {
          'light': ColorManger.lightRed,
          'primary': ColorManger.brightRed,
        };
      case 'Hospitals':
        return {
          'light': ColorManger.lightBlue,
          'primary': ColorManger.royalBlue,
        };
      case 'Admin':
        return {
          'light': ColorManger.lightPurple,
          'primary': ColorManger.brightPurple,
        };
      default:
        return {
          'light': ColorManger.grey300,
          'primary': ColorManger.grey500,
        };
    }
  }


  bool get _isDonor => user.role == 'Donor';

  bool get _isHospital => user.role == 'Hospitals';

  bool get _isAdmin => user.role == 'Admin';

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomDialogHeader(
                    title: appLocalization.userDetails,
                    subtitle: appLocalization.userDetailsSubtitle,
                  ),
                  const SizedBox(height: 20),
                  UserCard(user: user, showMenu: false),
                  const SizedBox(height: 16),
                  _buildContactSection(appLocalization),
                  const SizedBox(height: 8),
                  _buildRoleSpecificContent(appLocalization),
                  const SizedBox(height: 16),
                  AdminActionCard(
                    user: user,
                    onDeleteUser: () {
                      _showSnackBar(
                        context,
                        '${user.name} ${appLocalization.deleteUser}',
                      );
                    },
                    onEditUser: (name, phone) {
                      user.name = name;
                      user.phone = phone;
                      _showSnackBar(
                        context,
                        '${appLocalization.edit} ${user.name}',
                      );
                    },
                    onToggleVerification: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(AppLocalizations appLocalization) {
    return Column(
      children: [
        ContactTile(
          buttonText: appLocalization.call,
          icon: Icons.phone,
          label: appLocalization.phone,
          value: user.phone,
          onPressed: () => callUser(user.phone),
        ),
        const SizedBox(height: 8),
        ContactTile(
          buttonText: appLocalization.email,
          icon: Icons.email,
          label: appLocalization.email,
          value: user.email,
          onPressed: () => sendEmail(
            user.email,
            appLocalization.donationMessage,
            appLocalization.donationMessage,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSpecificContent(AppLocalizations appLocalization) {
    final colors = _getColorsByRole();

    if (_isDonor) {
      return Row(
        children: [
          Expanded(
            child: SummaryCard(
              backgroundColor: colors['light']!,
              title: appLocalization.bloodType,
              value: user.bloodType,
              valueColor: colors['primary']!,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SummaryCard(
              backgroundColor: ColorManger.lightGreen,
              title: appLocalization.donations,
              value: user.totalDonations.toString(),
              valueColor: ColorManger.green,
            ),
          ),
        ],
      );
    } else if (_isHospital) {
      return SummaryCard(
        backgroundColor: colors['light']!,
        title: appLocalization.totalRequests,
        value: '120',
        valueColor: colors['primary']!,
      );
    } else if (_isAdmin) {
      return SummaryCard(
        backgroundColor: colors['light']!,
        title: appLocalization.adminRole,
        value: appLocalization.systemAdministrator,
        valueColor: colors['primary']!,
      );
    }

    return const SizedBox.shrink();
  }

  Future<void> callUser(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        debugPrint('Cannot launch phone call: $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching phone call: $e');
    }
  }

  Future<void> sendEmail(String email, String subject, String body) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': subject, 'body': body},
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
        return;
      }

      // Fallback to Gmail web if native email fails
      final Uri gmailWeb = Uri.parse(
        'https://mail.google.com/mail/?view=cm&to=$email&su=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
      );

      if (await canLaunchUrl(gmailWeb)) {
        await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch any email client.');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        backgroundColor: ColorManger.successColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: CustomText(
          text:
          message,
          textStyle: const TextStyle(color: ColorManger.pureWhite, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
