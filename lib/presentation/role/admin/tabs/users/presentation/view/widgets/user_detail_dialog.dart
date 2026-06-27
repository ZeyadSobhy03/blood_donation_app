import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/summary_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_edit_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../hospital/tabs/find_donor/widgets/contact_tile.dart';
import '../../../../../../hospital/tabs/home/section/request_header.dart';
import '../../view_model/users_view_model.dart';
import 'admin_action_card.dart';

class UserDetailDialog extends StatelessWidget {
  const UserDetailDialog({super.key, required this.user});

  final Users user;

  static const String _roleDonor = 'donor';
  static const String _roleHospital = 'hospital';
  static const String _roleAdmin = 'admin';

  Map<String, Color> _getColorsByRole() {
    switch (user.role) {
      case _roleDonor:
        return {
          'light': ColorManger.lightRed,
          'primary': ColorManger.brightRed,
        };
      case _roleHospital:
        return {
          'light': ColorManger.lightBlue,
          'primary': ColorManger.royalBlue,
        };
      case _roleAdmin:
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

  bool get _isDonor => user.role == _roleDonor;

  bool get _isHospital => user.role == _roleHospital;

  bool get _isAdmin => user.role == _roleAdmin;

  bool get _isBanned => user.isSuspended ?? false;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final usersCubit = context.read<UsersCubit>();

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
                    onDeleteUser: () =>
                        _confirmAndDeleteUser(context, usersCubit, appLocalization),
                    onEditUser: () =>
                        _handleEditUser(context, usersCubit, appLocalization),
                    onToggleVerification: () =>
                        _confirmAndToggleBan(context, usersCubit, appLocalization),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleEditUser(
      BuildContext context,
      UsersCubit usersCubit,
      AppLocalizations appLocalization,
      ) async {
    final data = await UserEditSheet.show(context, user);
    if (data == null) return;

    final userId = user.id ?? '';
    if (userId.isEmpty) return;

    if (!context.mounted) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    Navigator.of(context).pop();

    ActionResult result;
    final type = data['type'] as String;

    switch (type) {
      case 'donor':
        result = await usersCubit.updateDonor(
          fullName: data['fullName'] as String,
          phoneNumber: data['phoneNumber'] as String,
          bloodType: data['bloodType'] as String,
          userId: userId,
        );
        break;
      case 'hospital':
        result = await usersCubit.updateHospital(
          fullName: data['fullName'] as String,
          hospitalName: data['hospitalName'] as String,
          phone: data['phone'] as String,
          bloodBanksAvailable: List<String>.from(data['bloodBanksAvailable']),
          capacity: data['capacity'] as int,
          userId: userId,
        );
        break;
      case 'admin':
        result = await usersCubit.updateAdmin(
          fullName: data['fullName'] as String,
          isSuspended: data['isSuspended'] as bool,
          userId: userId,
        );
        break;
      default:
        return;
    }

    if (result.success) {
      _showSnackBar(messenger, appLocalization.updateSuccess);
    } else {
      _showSnackBar(
        messenger,
        localizeError(result.errorMessage ?? 'unknown_error', appLocalization),
        isError: true,
      );
    }
  }

  Future<void> _confirmAndDeleteUser(
      BuildContext context,
      UsersCubit usersCubit,
      AppLocalizations appLocalization,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: ColorManger.pureWhite,
        title: CustomText(text: appLocalization.deleteUser),
        content: CustomText(
          text:
          '${appLocalization.deleteUserConfirmation} ${user.fullName ?? user.name ?? ''}?',
        ),
        actions: [
          CustomElevatedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: ColorManger.brightRed,
            elevation: 0,
            foregroundColor: ColorManger.pureWhite,
            onPressed: () => Navigator.of(context).pop(false),
            child: CustomText(text: appLocalization.cancel),
          ),
          CustomElevatedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: ColorManger.successColor,
            foregroundColor: ColorManger.pureWhite,
            onPressed: () => Navigator.of(context).pop(true),
            child: CustomText(text: appLocalization.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final userId = user.id ?? '';
    if (userId.isEmpty) return;

    if (!context.mounted) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    Navigator.of(context).pop();

    final result = await usersCubit.deleteUser(userId: userId);

    if (result.success) {
      _showSnackBar(
        messenger,
        '${user.fullName ?? user.name ?? ''} ${appLocalization.deleteUser}',
      );
    } else {
      _showSnackBar(messenger, localizeError(result.errorMessage ??appLocalization.unknown_error,appLocalization ) , isError: true);
    }
  }

  Future<void> _confirmAndToggleBan(
      BuildContext context,
      UsersCubit usersCubit,
      AppLocalizations appLocalization,
      ) async {
    final userId = user.id ?? '';
    if (userId.isEmpty) return;

    if (_isBanned) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: ColorManger.pureWhite,
          title: CustomText(text: appLocalization.unbanUser),
          content: CustomText(
            text:
            '${appLocalization.unbanUserConfirmation} ${user.fullName ?? user.name ?? ''}?',
          ),
          actions: [
            CustomElevatedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: ColorManger.brightRed,
              elevation: 0,
              foregroundColor: ColorManger.pureWhite,
              onPressed: () => Navigator.of(context).pop(false),
              child: CustomText(text: appLocalization.cancel),
            ),
            CustomElevatedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: ColorManger.successColor,
              foregroundColor: ColorManger.pureWhite,
              onPressed: () => Navigator.of(context).pop(true),
              child: CustomText(text: appLocalization.unban),
            ),
          ],
        ),
      );

      if (confirmed != true || !context.mounted) return;

      final messenger = ScaffoldMessenger.maybeOf(context);
      Navigator.of(context).pop();

      final result = await usersCubit.unbanUser(userId: userId);
      _handleBanResult(messenger, result, appLocalization, wasUnban: true);
      return;
    }

    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: ColorManger.pureWhite,
        title: CustomText(text: appLocalization.banUser),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
              '${appLocalization.banUserConfirmation} ${user.fullName ?? user.name ?? ''}?',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: appLocalization.banReasonHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          CustomElevatedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: ColorManger.brightRed,
            foregroundColor: ColorManger.pureWhite,
            onPressed: () => Navigator.of(context).pop(false),
            child: CustomText(text: appLocalization.cancel),
          ),
          CustomElevatedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: ColorManger.successColor,
            foregroundColor: ColorManger.pureWhite,
            onPressed: () => Navigator.of(context).pop(true),
            child: CustomText(text: appLocalization.ban),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final reason = reasonController.text.trim();
    if (reason.isEmpty) return;

    final messenger = ScaffoldMessenger.maybeOf(context);
    Navigator.of(context).pop();

    final result = await usersCubit.banUser(userId: userId, reason: reason);
    _handleBanResult(messenger, result, appLocalization, wasUnban: false);
  }

  void _handleBanResult(
      ScaffoldMessengerState? messenger,
      ActionResult result,
      AppLocalizations appLocalization, {
        required bool wasUnban,
      }) {
    if (result.success) {
      _showSnackBar(
        messenger,
        wasUnban
            ? '${user.fullName ?? user.name ?? ''} ${appLocalization.unbanUser}'
            : '${user.fullName ?? user.name ?? ''} ${appLocalization.banUser}',
      );
    } else {
      _showSnackBar(
        messenger,
        localizeError(result.errorMessage ?? 'unknown_error', appLocalization),
        isError: true,
      );
    }
  }

  Widget _buildContactSection(AppLocalizations appLocalization) {
    return Column(
      children: [
        ContactTile(
          buttonText: appLocalization.call,
          icon: Icons.phone,
          label: appLocalization.phone,
          value: user.phoneNumber ?? '',
          onPressed: () => callUser(user.phone ?? ''),
        ),
        const SizedBox(height: 8),
        ContactTile(
          buttonText: appLocalization.email,
          icon: Icons.email,
          label: appLocalization.email,
          value: user.email ?? '',
          onPressed: () => sendEmail(
            user.email ?? '',
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
              value: user.bloodType ?? '-',
              valueColor: colors['primary']!,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SummaryCard(
              backgroundColor: ColorManger.lightGreen,
              title: appLocalization.donations,
              value: (user.totalDonations ?? 0).toString(),
              valueColor: ColorManger.green,
            ),
          ),
        ],
      );
    } else if (_isHospital) {
      return SummaryCard(
        backgroundColor: colors['light']!,
        title: appLocalization.totalRequests,
        value: '${user.totalDonations ?? 0}',
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
    if (phoneNumber.isEmpty) return;
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

  void _showSnackBar(ScaffoldMessengerState? messenger, String message,
      {bool isError = false}) {
    messenger?.showSnackBar(
      SnackBar(
        backgroundColor:
        isError ? ColorManger.brightRed : ColorManger.successColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: CustomText(
          text: message,
          textStyle: const TextStyle(
            color: ColorManger.pureWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}