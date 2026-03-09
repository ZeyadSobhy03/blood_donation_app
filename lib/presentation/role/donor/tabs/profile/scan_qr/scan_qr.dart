import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/scan_qr/section/donation_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../core/resources/models/donation_details.dart';
import '../../../../../../l10n/app_localizations.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> with SingleTickerProviderStateMixin {
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

  Future<void> sendQrToApi(String code) async {
    debugPrint("Sending QR: $code");

    await Future.delayed(const Duration(seconds: 1));

    showSuccessDialog();
  }

  void detectBarcode(BarcodeCapture capture) {
    if (_scanned) return;

    final barcode = capture.barcodes.first;
    final String? code = barcode.rawValue;

    if (code != null) {
      setState(() => _scanned = true);

      _controller.stop();

      sendQrToApi(code);
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => DonationConfirmDialog(
        donation: DonationDetails(
          type: "Whole Blood",
          date: DateTime.now(),
          location: "City Hospital",
          status: DonationStatus.confirmed,
        ),
        pointsEarned: 50,
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
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: detectBarcode),

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
              padding: const EdgeInsets.only(bottom: 80),
              child: CustomText(
                text: loc.align_qr_frame,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  color: ColorManger.pureWhite.withValues(alpha: 0.85),
                ),
              ),
            ),
          ),
        ],
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
