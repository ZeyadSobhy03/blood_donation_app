
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../../core/resources/models/user_role.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late UserRole role;
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  int _currentPage = 0;
  int _totalPages = 0;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    role = ModalRoute.of(context)!.settings.arguments as UserRole;
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  Color get primaryColor {
    switch (role) {
      case UserRole.donor:
        return ColorManger.brightRed;
      case UserRole.hospital:
        return ColorManger.royalBlue;
    }
  }

  String get pdfPath {

    switch (role) {
      case UserRole.donor:
        return 'assets/docs/donor.pdf';
      case UserRole.hospital:
        return 'assets/docs/hospital.pdf';
    }
  }

  void _retryLoading() {                  // ← new
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
      _currentPage = 0;
      _totalPages = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: ColorManger.pureWhite,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: appLocalizations.pdfViewer,
                textStyle: TextStyle(
                  color: ColorManger.pureWhite,
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSize.s16,
                ),
              ),
              if (_totalPages > 0)
                CustomText(
                  text: appLocalizations.pageOf(_currentPage, _totalPages),
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite.withValues(alpha: 0.9),
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s12,
                  ),
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (!_hasError) _buildPdfViewer(),   // ← don't render viewer on error
            if (_isLoading && !_hasError)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: 16.h),
                      CustomText(
                        text: appLocalizations.loadingPdf,
                        textStyle: TextStyle(
                          color: ColorManger.slateGrey,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_hasError) _buildErrorState(appLocalizations),  // ← new
          ],
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return SfPdfViewer.asset(
      pdfPath,
      key: _pdfViewerKey,
      controller: _pdfViewerController,
      onDocumentLoaded: (details) {
        setState(() {
          _totalPages = details.document.pages.count;
          _isLoading = false;
        });
      },
      onPageChanged: (details) {
        setState(() {
          _currentPage = details.newPageNumber;
        });
      },
      onDocumentLoadFailed: (details) {   // ← new
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = details.description;
        });
      },
    );
  }

  Widget _buildErrorState(AppLocalizations appLocalizations) {   // ← new
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.broken_image_outlined,
                size: 64.sp,
                color: primaryColor.withValues(alpha: 0.6),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: appLocalizations.pdfLoadError,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSize.s16,
                ),
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: _errorMessage,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey.withValues(alpha: 0.7),
                  fontSize: FontSize.s13,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: _retryLoading,
                icon: const Icon(Icons.refresh_rounded),
                label: CustomText( text:appLocalizations.retry ,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: ColorManger.pureWhite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}