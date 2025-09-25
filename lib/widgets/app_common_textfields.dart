import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';

import '../utils/app_utils.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? prefixText;
  final String? suffixText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? isNotEnabled;
  final int? maxLength;
  final FocusNode focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool showLabel;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPaddingOverride;
  final TextStyle? hintTextStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final bool? isFilledColor;
  final TextStyle? style;
  final int? maxLines;

  const AppTextField({
    Key? key,
    required this.label,
    this.hint,
    this.prefixText,
    this.suffixText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isNotEnabled,
    this.maxLength,
    required this.focusNode,
    this.inputFormatters,
    this.showLabel = true,
    this.textAlign,
    this.contentPaddingOverride,
    this.hintTextStyle,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.isFilledColor,
    this.style,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: AppTextStyles.regular.copyWith(color: AppColor.blackColor,fontSize: 16)
          ),
          const SizedBox(height: 6),
        ],
        KeyboardActions(
          disableScroll: true,
          config: AppUtils.instance.keyboardConfigIos(focusNode),
          child: Container(
            decoration: (isFilledColor ?? false) ? BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.textFieldBorderColor),
            ) : BoxDecoration(),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              enabled: isNotEnabled ?? true,
              validator: validator,
              maxLength: maxLength,
              maxLines: maxLines,
              inputFormatters: inputFormatters,
              textAlign: textAlign ?? TextAlign.start,
              style: style ?? TextStyle(),
              decoration: InputDecoration(
                hintText: hint,
                prefix: prefixText != null ? Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Text(
                    prefixText!,
                    style: AppTextStyles.medium.copyWith(fontSize: 18, color: AppColor.blackColor),
                  ),
                ) : null,
                suffix: suffixText != null ? Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: Text(
                    suffixText!,
                    style: AppTextStyles.bold.copyWith(fontSize: 18, color: AppColor.primary),
                  ),
                ) : null,
                errorStyle: AppTextStyles.regular.copyWith(fontSize: 12,color: AppColor.redColor),
                hintStyle: hintTextStyle ?? AppTextStyles.medium.copyWith(fontSize: 18,color: AppColor.blackColor),
                counterText: "", // Hide character counter
                contentPadding: contentPaddingOverride ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: border ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.textFieldBorderColor),
                ),
                enabledBorder: enabledBorder ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.textFieldBorderColor),
                ),
                disabledBorder: (isFilledColor ?? false) ? InputBorder.none : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.textFieldBorderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.redColor),
                ),
                focusedBorder: focusedBorder ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.primary, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
