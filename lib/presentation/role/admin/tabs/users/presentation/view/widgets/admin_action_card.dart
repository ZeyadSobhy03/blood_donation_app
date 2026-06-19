import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/presentation/view/widgets/user_edit_sheet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../l10n/app_localizations.dart';


class AdminActionCard extends StatelessWidget {
  const AdminActionCard({
    super.key,
    required this.user,
    this.onToggleVerification,
    this.onDeleteUser,
    this.onEditUser,
  });

  final Users user;
  final VoidCallback? onToggleVerification;
  final VoidCallback? onDeleteUser;
  final void Function(String name, String phone)? onEditUser;
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(
    horizontal: 26,
    vertical: 16,
  );

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: ColorManger.pureWhite,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: ColorManger.lightGrey.withValues(alpha: 0.7),
          width: 1.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomText(
              text: appLocalization.adminActions,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            const SizedBox(height: 16),
            user.isVerified ?? false
                ? _buildActionButton(
                    text: appLocalization.suspendUser,
                    onPressed: () => onToggleVerification?.call(),
                    haveIcon: true,
                    icon: Icons.block,
                    textColor: ColorManger.brightRed,
                  )
                : _buildActionButton(
                    text: appLocalization.verifyUser,
                    onPressed: () => onToggleVerification?.call(),
                    haveIcon: true,
                    icon: Icons.verified_outlined,
                    textColor: ColorManger.green,
                    backgroundColor: ColorManger.lightGreen,
                  ),
            const SizedBox(height: 12),
            _buildActionButton(
              text: appLocalization.sendMessage,
              onPressed: () => sendWhatsapp(
                phoneNumber: user.phone,
                message:
                    '${appLocalization.hello} ${user.name}, ${appLocalization.iNeedToContactYouRegardingYourAccount}',
              ),
              haveIcon: false,
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              text: appLocalization.edit,
              onPressed: () => _openEditSheet(context),
              haveIcon: false,
            ),
            const SizedBox(height: 12),
            _buildActionButton(
              text: appLocalization.delete,
              textColor: ColorManger.brightRed,
              onPressed: () => _confirmAndDelete(context, appLocalization),
            ),
            const SizedBox(height: 18),
            _buildActionButton(
              text: appLocalization.close,
              onPressed: () {
                Navigator.pop(context);
              },
              haveIcon: false,
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    AppLocalizations appLocalization,
  ) async {
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: CustomText(text: appLocalization.deleteUser),
        content: CustomText(text: appLocalization.deleteUserConfirm),
        actions: [
          CustomElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            backgroundColor: ColorManger.pureWhite,
            foregroundColor: ColorManger.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: ColorManger.slateGrey.withValues(alpha: 0.3),
                width: 1.1,
              ),
            ),
            child: CustomText(text: appLocalization.cancel),
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            backgroundColor: ColorManger.brightRed,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: ColorManger.brightRed.withValues(alpha: 0.55),
                width: 1,
              ),
            ),
            child: CustomText(
              text: appLocalization.delete,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    if (confirmed == true) {
      onDeleteUser?.call();
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
  }

  void _openEditSheet(BuildContext context) {
    if (onEditUser == null) return;
    UserEditSheet.show(
      context,
      user,
      (name, phone) => onEditUser?.call(name, phone),
    );
  }

  void sendWhatsapp({
    required String phoneNumber,
    required String message,
  }) async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  Widget _buildActionButton({
    bool haveIcon = false,
    Color backgroundColor = ColorManger.pureWhite,
    Color foregroundColor = ColorManger.black,
    required String text,
    required VoidCallback onPressed,
    Color textColor = ColorManger.black,

    IconData? icon,
  }) {
    return CustomElevatedButton(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      padding: _buttonPadding,
      onPressed: onPressed,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: haveIcon
              ? textColor.withValues(alpha: 0.5)
              : ColorManger.slateGrey.withValues(alpha: 0.3),
          width: 1.1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (haveIcon == true) Icon(icon, size: 20, color: textColor),
          if (haveIcon == true) const SizedBox(width: 8),
          CustomText(
            text: text,
            textStyle: TextStyle(
              color: textColor,
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.medium,
            ),
          ),
        ],
      ),
    );
  }
}
