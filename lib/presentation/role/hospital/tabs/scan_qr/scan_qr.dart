import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_hive_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/appointments/data/data_source/appointments_api_data_source.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/appointments/data/repository/appointments_repository_imp.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/appointments/domain/use_cases/appointments_use_case.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/appointments/presentation/view_model/appointments_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/appointments/widgets/eligibility_checklist_screen.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/appointments/widgets/manual_code_entry_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../l10n/app_localizations.dart';

class ScanQr extends StatelessWidget {
  const ScanQr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AppointmentsCubit(
        appointmentsUseCase: AppointmentsUseCase(
          repository: AppointmentsRepositoryImp(
            remoteDataSource: AppointmentsApiDataSource(Dio()),
          ),
        ),
        hospitalLocalDataSource: context.read<HospitalHiveDataSource>(),
        loc: AppLocalizations.of(ctx),
      ),
      child: const _ScanQrView(),
    );
  }
}

class _ScanQrView extends StatefulWidget {
  const _ScanQrView();

  @override
  State<_ScanQrView> createState() => _ScanQrViewState();
}

class _ScanQrViewState extends State<_ScanQrView>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _controller = MobileScannerController();

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

  void _detectBarcode(BarcodeCapture capture) {
    if (_scanned) return;

    final barcode = capture.barcodes.first;
    final String? qrToken = barcode.rawValue;

    if (qrToken != null && qrToken.isNotEmpty) {
      setState(() => _scanned = true);
      _controller.stop();
      context.read<AppointmentsCubit>().verifyQrCode(qrToken);
    }
  }

  void _resumeScanning() {
    context.read<AppointmentsCubit>().resetToAppointments();
    setState(() => _scanned = false);
    _controller.start();
  }

  void _openManualEntry() {
    _controller.stop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AppointmentsCubit>(),
          child: const ManualCodeEntryScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.black,
      body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is VerifyQrSuccessState) {
            Navigator.push(
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
              MobileScanner(controller: _controller, onDetect: _detectBarcode),
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
                        text: loc.scan_donation_qr,
                        textStyle: TextStyle(
                          fontSize: FontSize.s18,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManger.pureWhite,
                        ),
                      ),
                      _buildIconButton(
                        icon: _torchOn ? Icons.flash_on : Icons.flash_off,
                        onPressed: () {
                          _controller.toggleTorch();
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
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isVerifying)
                        TextButton.icon(
                          onPressed: _openManualEntry,
                          icon: Icon(Icons.keyboard, color: ColorManger.pureWhite),
                          label: CustomText(
                            text: loc.enterCodeManually,
                            textStyle: TextStyle(
                              fontSize: FontSize.s14,
                              color: ColorManger.pureWhite,
                            ),
                          ),
                        ),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: isVerifying ? loc.verifyingQrCode : loc.align_qr_frame,
                        textStyle: TextStyle(
                          fontSize: FontSize.s14,
                          color: ColorManger.pureWhite.withValues(alpha: 0.85),
                        ),
                      ),
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