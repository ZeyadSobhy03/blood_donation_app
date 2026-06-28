import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../../../l10n/app_localizations.dart';
import '../../../appointments/presentation/view_model/appointments_view_model.dart';
import 'eligibility_checklist_screen.dart';
import 'manual_code_entry_screen.dart';

class AppointmentScanFlowScreen extends StatefulWidget {
  const AppointmentScanFlowScreen({super.key});

  @override
  State<AppointmentScanFlowScreen> createState() =>
      _AppointmentScanFlowScreenState();
}

class _AppointmentScanFlowScreenState
    extends State<AppointmentScanFlowScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _scannerController =
      MobileScannerController();
  bool _scanned = false;
  bool _torchOn = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onBarcodeDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final barcode = capture.barcodes.first;
    final qrToken = barcode.rawValue;
    if (qrToken != null && qrToken.isNotEmpty) {
      setState(() => _scanned = true);
      _scannerController.stop();
      context.read<AppointmentsCubit>().verifyQrCode(qrToken);
    }
  }

  void _resumeScanning() {
    context.read<AppointmentsCubit>().resetToAppointments();
    setState(() => _scanned = false);
    _scannerController.start();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.black,
      body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
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
                      _resumeScanning();
                    },
                  ),
                ),
              ),
            );
          } else if (state is VerifyQrErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) _resumeScanning();
            });
          }
        },
        builder: (context, state) {
          final isVerifying = state is VerifyQrLoadingState;

          return Stack(
            children: [
              MobileScanner(
                controller: _scannerController,
                onDetect: _onBarcodeDetect,
              ),
              Center(
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManger.primaryRed,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      if (!isVerifying)
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Positioned(
                              top: 260 * _animationController.value,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 3,
                                color: ColorManger.primaryRed,
                              ),
                            );
                          },
                        ),
                      if (isVerifying)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomText(
                        text: loc.scan_qr_code,
                        textStyle: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManger.pureWhite,
                        ),
                      ),
                      _buildIconButton(
                        icon: _torchOn ? Icons.flash_on : Icons.flash_off,
                        onPressed: () {
                          _scannerController.toggleTorch();
                          setState(() => _torchOn = !_torchOn);
                        },
                        isActive: _torchOn,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: isVerifying
                            ? loc.verifyingQrCode
                            : loc.scanQrInstructionTitle,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.pureWhite.withValues(alpha: 0.85),
                        ),
                      ),
                      if (!isVerifying) ...[
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            _scannerController.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<AppointmentsCubit>(),
                                  child: const ManualCodeEntryScreen(),
                                ),
                              ),
                            ).then((_) {
                              if (mounted) _scannerController.start();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManger.pureWhite.withValues(alpha: 0.5),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard,
                                  color: ColorManger.pureWhite.withValues(alpha: 0.85),
                                  size: 18,
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  text: loc.enterCodeManually,
                                  textStyle: TextStyle(
                                    fontSize: FontSize.s13,
                                    color: ColorManger.pureWhite.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: isActive
              ? ColorManger.primaryRed
              : ColorManger.pureWhite.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorManger.pureWhite),
      ),
    );
  }
}
