import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/widgets/custom_pin_code.dart';

class CustomPinVerificationScreen extends StatefulWidget {
  const CustomPinVerificationScreen({
    super.key,
    required this.args,
    this.onSubmit,
    this.onResend,
  });

  final PinVerificationArgs args;
  final Future<bool> Function(String pin)? onSubmit;
  final Future<void> Function()? onResend;

  String get title => args.title;
  VoidCallback? get onCancel => args.onCancel;
  String get subtitle => args.subtitle;
  String get submitText => args.submitText;
  String get cancelText => args.cancelText;
  String get invalidPinText => args.invalidPinText;
  AuthPinRole get role => args.role;
  int get pinLength => args.pinLength;
  PinVerificationStyle? get style => args.style;

  Future<bool> Function(String pin)? get submitHandler =>
      onSubmit ?? args.onSubmit;
  Future<void> Function()? get resendHandler => onResend ?? args.onResend;

  @override
  State<CustomPinVerificationScreen> createState() =>
      _CustomPinVerificationScreenState();
}

class _CustomPinVerificationScreenState
    extends State<CustomPinVerificationScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _pinController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _pinError;
  bool _isResending = false;
  bool _isSubmitting = false;

  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  _PinActionColors get _colors => _resolveActionColors(widget.role);

  Color get _screenBackground =>
      widget.style?.screenBackgroundColor ?? _colors.backgroundGradientStart;

  Color get _appBarBackground =>
      widget.style?.appBarBackgroundColor ?? Colors.transparent;

  Color get _appBarForeground =>
      widget.style?.appBarForegroundColor ?? ColorManger.black;

  Color get _subtitleColor =>
      widget.style?.subtitleColor ?? ColorManger.grey600;

  Color get _submitBackground =>
      widget.style?.submitBackgroundColor ?? _colors.primary;

  Color get _submitForeground =>
      widget.style?.submitForegroundColor ?? ColorManger.pureWhite;

  Color get _cancelBackground =>
      widget.style?.cancelBackgroundColor ?? Colors.transparent;

  Color get _cancelForeground =>
      widget.style?.cancelForegroundColor ?? _colors.primary;

  Color get _cancelBorder =>
      widget.style?.cancelBorderColor ?? _colors.primary.withValues(alpha: 0.3);

  double get _buttonRadius => widget.style?.buttonBorderRadius ?? 14;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _scrollController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final pin = _pinController.text.trim();
    if (pin.length != widget.pinLength) {
      setState(() {
        _pinError = AppLocalizations.of(context)!.invalid_pin_length;
      });
      return;
    }
    final handler = widget.submitHandler;
    if (handler != null) {
      setState(() => _isSubmitting = true);
      final isValid = await handler(pin);
      if (mounted) setState(() => _isSubmitting = false);
      if (mounted && !isValid) {
        setState(() => _pinError = widget.invalidPinText);
      }
    }
  }

  Future<void> _handleResend() async {
    final handler = widget.resendHandler;
    if (handler != null) {
      setState(() => _isResending = true);
      await handler();
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: _screenBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _appBarBackground,
        foregroundColor: _appBarForeground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: CustomText(
          text: widget.title,
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: _appBarForeground,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _appBarForeground.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: _appBarForeground,
            ),
          ),
          onPressed: widget.onCancel ?? () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: IgnorePointer(
              child: _GlowBlob(
                color: _colors.primary.withValues(alpha: 0.15),
                size: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -40,
            child: IgnorePointer(
              child: _GlowBlob(
                color: _colors.primary.withValues(alpha: 0.10),
                size: 160,
              ),
            ),
          ),

          // Main scrollable content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  // Extra bottom padding so content clears the keyboard
                  padding: EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),

                      _RoleIconBadge(role: widget.role, colors: _colors),
                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: _colors.primary.withValues(alpha: 0.10),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: ColorManger.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Subtitle
                              CustomText(
                                text: widget.subtitle,
                                textStyle: TextStyle(
                                  color: _subtitleColor,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // PIN Input
                              CustomPinCode(
                                controller: _pinController,
                                role: widget.role,
                                length: widget.pinLength,
                                errorText: _pinError,
                                onChanged: (_) {
                                  if (_pinError != null) {
                                    setState(() => _pinError = null);
                                  }
                                },
                                onCompleted: (pin) async {
                                  final handler = widget.submitHandler;
                                  if (handler != null) {
                                    setState(() => _isSubmitting = true);
                                    final isValid = await handler(pin);
                                    if (mounted) {
                                      setState(() => _isSubmitting = false);
                                      if (!isValid) {
                                        setState(() =>
                                        _pinError = widget.invalidPinText);
                                      }
                                    }
                                  }
                                },
                              ),

                              const SizedBox(height: 8),

                              // Resend row
                              Center(
                                child: TextButton(
                                  onPressed:
                                  _isResending ? null : _handleResend,
                                  style: TextButton.styleFrom(
                                    foregroundColor: _colors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: _isResending
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: _colors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      CustomText(
                                        text: AppLocalizations.of(
                                            context)!
                                            .donor_resending_code,
                                        textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: _colors.primary,
                                        ),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        size: 16,
                                        color: _colors.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      CustomText(
                                        text: AppLocalizations.of(
                                            context)!
                                            .donor_resend_code,
                                        textStyle: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: _colors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: CustomElevatedButton(
                                  onPressed:
                                  _isSubmitting ? null : _handleSubmit,
                                  backgroundColor: _submitBackground,
                                  foregroundColor: _submitForeground,
                                  elevation: _isSubmitting ? 0 : 3,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(_buttonRadius),
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: _isSubmitting
                                      ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: _submitForeground,
                                    ),
                                  )
                                      : CustomText(
                                    text: widget.submitText,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: _submitForeground,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Cancel Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: CustomElevatedButton(
                                  onPressed: widget.onCancel ?? () => Navigator.pop(context),
                                  backgroundColor: _cancelBackground,
                                  foregroundColor: _cancelForeground,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(_buttonRadius),
                                    side: BorderSide(
                                      color: _cancelBorder,
                                      width: 1.5,
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  child: CustomText(
                                    text: widget.cancelText,
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _cancelForeground,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _PinActionColors _resolveActionColors(AuthPinRole role) {
    switch (role) {
      case AuthPinRole.admin:
        return _PinActionColors(
          primary: ColorManger.brightPurple,
          secondaryBackground: ColorManger.lightPurple,
          backgroundGradientStart: const Color(0xFFF5F0FF),
          icon: Icons.admin_panel_settings_rounded,
        );
      case AuthPinRole.hospital:
        return _PinActionColors(
          primary: ColorManger.royalBlue,
          secondaryBackground: ColorManger.veryLightBlue,
          backgroundGradientStart: const Color(0xFFF0F4FF),
          icon: Icons.local_hospital_rounded,
        );
      case AuthPinRole.donor:
        return _PinActionColors(
          primary: ColorManger.brightRed,
          secondaryBackground: ColorManger.softRed,
          backgroundGradientStart: const Color(0xFFFFF0F0),
          icon: Icons.favorite_rounded,
        );
    }
  }
}

// ── Role Icon Badge ──────────────────────────────────────────────────────────

class _RoleIconBadge extends StatelessWidget {
  const _RoleIconBadge({required this.role, required this.colors});

  final AuthPinRole role;
  final _PinActionColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.primary.withValues(alpha: 0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        colors.icon,
        color: Colors.white,
        size: 34,
      ),
    );
  }
}

// ── Glow Blob ────────────────────────────────────────────────────────────────

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

// ── Color Model ──────────────────────────────────────────────────────────────

class _PinActionColors {
  const _PinActionColors({
    required this.primary,
    required this.secondaryBackground,
    required this.backgroundGradientStart,
    required this.icon,
  });

  final Color primary;
  final Color secondaryBackground;
  final Color backgroundGradientStart;
  final IconData icon;
}