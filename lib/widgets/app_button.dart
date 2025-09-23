import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_text_styles.dart';

import '../utils/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Widget? leading; // optional leading icon or widget
  final double gap;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.textStyle,
    this.leading,
    this.gap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor.primary,
          foregroundColor: textColor ?? AppColor.whiteColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: leading == null
            ? Text(
                text,
                style: textStyle ?? AppTextStyles.semiBold,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leading!,
                  SizedBox(width: gap),
                  Text(
                    text,
                    style: textStyle ?? AppTextStyles.semiBold,
                  ),
                ],
              ),
      ),
    );
  }
}
