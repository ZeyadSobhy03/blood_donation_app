import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
    this.elevation,
    this.foregroundColor,
    this.shape,
    this.padding,
  });

  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;

  final double? elevation;
  final Color? foregroundColor;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: elevation,
        foregroundColor: foregroundColor,
        shape: shape,
        padding: padding,
      ),

      onPressed: onPressed,
      child: child,
    );
  }
}
