import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/service/firebase_notification_service.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitialState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteManger.chooseRole,
                (route) => false,
          );
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: localizeError(state.errorKey, appLocalization),
              ),
            ),
          );
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 70.h, maxWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: ColorManger.brightRed.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            elevation: 0,
            foregroundColor: ColorManger.brightRed,
            backgroundColor: ColorManger.pureWhite,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            onPressed: () async {
              final authCubit = context.read<AuthCubit>();
              final refreshToken =
              await authCubit.authHiveDataSource.getRefreshToken();
              final fcmToken =
              await FirebaseNotificationService.getFCMToken();

              if (context.mounted) {
                authCubit.logOut(
                  refreshToken: refreshToken ?? '',
                  fcmToken: fcmToken ?? '',
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return SizedBox(
                  height: 24,
                  child: state is AuthLoadingState
                      ? const AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: ColorManger.brightRed,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: ColorManger.brightRed,
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        text: appLocalization.logout,
                        textStyle: TextStyle(
                          color: ColorManger.brightRed,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}