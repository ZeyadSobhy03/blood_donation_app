// ...existing code...
import 'dart:developer';

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
import '../../../../../../../core/utils/error_localizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
  String? _lastScannedToken;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  bool _appLocSet = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_appLocSet) {
      final loc = AppLocalizations.of(context)!;
      try {
        context.read<AppointmentsCubit>().setAppLoc(loc);
      } catch (_) {}
      _appLocSet = true;
    }
  }

  void _detectBarcode(BarcodeCapture capture) {
    if (_scanned) return;

    // Guard: onDetect can fire with an empty barcodes list (e.g. a frame
    // with nothing decodable). Calling .first on an empty list throws a
    // StateError and crashes the scanner, so bail out early instead.
    if (capture.barcodes.isEmpty) return;

    final barcode = capture.barcodes.first;
    final String? qrToken = barcode.rawValue;

    if (qrToken != null && qrToken.isNotEmpty) {
      final scanned = _normalizeQrToken(qrToken);
      _lastScannedToken = scanned;
      log('Normalized QR token: $scanned');
      if (kDebugMode) {
        // ignore: avoid_print
        print('Scanned QR token: $scanned');
      }
      setState(() => _scanned = true);
      _controller.stop();
      context.read<AppointmentsCubit>().verifyQrCode(scanned);
    }
  }


  String _normalizeQrToken(String rawValue) {
    final trimmed = rawValue.trim();

    final uri = Uri.tryParse(trimmed);
    if (uri == null) return trimmed;

    final queryToken = uri.queryParameters['qrToken'] ?? uri.queryParameters['token'];
    if (queryToken != null && queryToken.isNotEmpty) {
      return queryToken.trim();
    }

    if (uri.pathSegments.isNotEmpty) {
      final lastSegment = uri.pathSegments.last.trim();
      if (lastSegment.isNotEmpty) {
        return lastSegment;
      }
    }

    return trimmed;
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
            final loc = AppLocalizations.of(context)!;
            final localized = localizeError(state.message, loc);
            final snackText = kDebugMode ? '$localized — raw: ${state.message}' : localized;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(snackText)),
            );
            // In debug mode, try fetching hospital appointments and searching for the scanned QR token
            if (kDebugMode && _lastScannedToken != null) {
              () async {
                try {
                  final hospitalLocal = context.read<HospitalHiveDataSource>();
                  final token = await hospitalLocal.getAccessToken();
                  if (token == null) return;
                  final dio = Dio();
                  final response = await dio.get(ApiManger.hospitalAppointmentsEndpoint,
                      options: Options(headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                        'Authorization': 'Bearer $token',
                      }));
                  // raw data may be Map with data.appointments array
                  final data = response.data;
                  // Search recursively for qrToken field in the response
                  bool found = false;
                  dynamic foundItem;
                  void search(dynamic node) {
                    if (node == null) return;
                    if (node is Map) {
                      if (node['qrToken'] != null && node['qrToken'] == _lastScannedToken) {
                        found = true;
                        foundItem = node;
                        return;
                      }
                      node.values.forEach(search);
                    } else if (node is List) {
                      for (final e in node) {
                        if (found) break;
                        search(e);
                      }
                    }
                  }
                  search(data);
                  if (found) {
                    // show a helpful snack and print details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Debug: token found in hospital appointments. See console for details.')),
                    );
                    // ignore: avoid_print
                    print('DEBUG: Found appointment for token: $_lastScannedToken');
                    // ignore: avoid_print
                    print(foundItem);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Debug: token not found in hospital appointments.')),
                    );
                  }
                } catch (e) {
                  // ignore: avoid_print
                  print('Debug fetch appointments error: $e');
                }
              }();
            }
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
              // Debug overlay: show last scanned token and copy button in debug mode
              if (kDebugMode && _lastScannedToken != null)
                Positioned(
                  top: 48,
                  right: 12,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await Clipboard.setData(ClipboardData(text: _lastScannedToken!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Scanned token copied to clipboard')),
                        );
                      } catch (_) {}
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorManger.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.qr_code, color: Colors.white, size: 16),
                          const SizedBox(width: 6),
                          SizedBox(
                            width: 180,
                            child: Text(
                              _lastScannedToken!,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.copy, color: Colors.white, size: 14),
                        ],
                      ),
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