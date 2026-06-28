import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/presentation/view_model/appointments_view_model.dart';
import 'appointment_scan_flow_screen.dart';
import 'eligibility_checklist_screen.dart';

class ManualCodeEntryScreen extends StatefulWidget {
  const ManualCodeEntryScreen({super.key});

  @override
  State<ManualCodeEntryScreen> createState() => _ManualCodeEntryScreenState();
}

class _ManualCodeEntryScreenState extends State<ManualCodeEntryScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isVerifying = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() {
    final code = _codeController.text.trim();
    if (code.isEmpty) return;
    setState(() => _isVerifying = true);
    context.read<AppointmentsCubit>().verifyQrCode(code);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.black,
      appBar: AppBar(
        backgroundColor: ColorManger.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          text: loc.scan_qr_code,
          textStyle: TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManger.pureWhite,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.flash_off, color: ColorManger.pureWhite),
          ),
        ],
      ),
      body: BlocListener<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is VerifyQrSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AppointmentsCubit>(),
                  child: EligibilityChecklistScreen(
                    verifyData: state.data,
                    onBack: () {
                      Navigator.pop(context);
                      setState(() => _isVerifying = false);
                    },
                  ),
                ),
              ),
            );
          } else if (state is VerifyQrErrorState) {
            setState(() => _isVerifying = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: ColorManger.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: loc.manualEntry,
                        textStyle: TextStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManger.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: loc.enterDonationCode,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.slateGrey,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomText(
                        text: loc.donationCodeLabel,
                        textStyle: TextStyle(
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManger.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          hintText: loc.donationCodeHint,
                          hintStyle: TextStyle(
                            color: ColorManger.grey400,
                            fontSize: FontSize.s14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: ColorManger.lightGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: ColorManger.lightGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: ColorManger.royalBlue),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: _isVerifying ? null : _verifyCode,
                          backgroundColor: ColorManger.royalBlue,
                          foregroundColor: ColorManger.pureWhite,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _isVerifying
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : CustomText(
                                  text: loc.verifyCode,
                                  textStyle: TextStyle(
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManger.pureWhite,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AppointmentsCubit>(),
                          child: const AppointmentScanFlowScreen(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.qr_code, color: ColorManger.pureWhite),
                  label: CustomText(
                    text: loc.scanQrInstead,
                    textStyle: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManger.pureWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
