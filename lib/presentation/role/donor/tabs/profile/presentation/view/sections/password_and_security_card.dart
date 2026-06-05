import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../view_model/change_password/change_password_view_model.dart';
import '../widgets/change_password_dialog.dart';
import '../widgets/security_tile.dart';

class PasswordAndSecurityCard extends StatefulWidget {
  const PasswordAndSecurityCard({super.key});

  @override
  State<PasswordAndSecurityCard> createState() =>
      _PasswordAndSecurityCardState();
}

class _PasswordAndSecurityCardState extends State<PasswordAndSecurityCard> {
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      color: ColorManger.pureWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.lock, color: ColorManger.slateGrey),
                SizedBox(width: 4.w),
                CustomText(
                  text: appLocations.passwordAndSecurity,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SecurityTile(
              icon: Icons.key,
              title: appLocations.changePassword,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: context.read<ChangePasswordCubit>(),
                    child: ChangePasswordDialog(
                      currentController: currentController,
                      newController: newController,
                      confirmController: confirmController,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}