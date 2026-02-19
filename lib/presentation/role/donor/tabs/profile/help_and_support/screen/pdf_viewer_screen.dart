import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  int _currentPage = 0;
  int _totalPages = 0;
  bool _isLoading = true;

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor:ColorManger.pureWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.brightRed,
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
                  text: appLocalizations.pageOf(_currentPage, _totalPages)  ,
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
            _buildPdfViewer(),
            if (_isLoading)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: ColorManger.brightRed),
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
          ],
        ),
      ),
      // Bottom Controls
    );
  }

  Widget _buildPdfViewer() {
    return SfPdfViewer.asset(
      'assets/docs/arabic.pdf',
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

    );
  }


}


