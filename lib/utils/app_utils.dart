
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart' show KeyboardActionsConfig;
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';

class AppUtils {

  AppUtils._privateConstructor();
  static final AppUtils instance = AppUtils._privateConstructor();

  keyboardConfigIos(FocusNode focusNode) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: [
          KeyboardActionsItem(
              focusNode: focusNode,
              displayDoneButton: true,
              displayArrows: false)
        ]);
  }

  // PAN validator helper compatible with provided signature
  String? panNumberValidator(String? value, BuildContext context, {
    String emptyMessage = AppCommonString.pleaseEnterPanNumber,
    String invalidMessage = AppCommonString.enterValidPanNumber,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    final regExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if (!regExp.hasMatch(value.toUpperCase())) {
      return invalidMessage;
    }
    return null;
  }

  /// Show snackbar with custom styling
  void showSnackBar(
      BuildContext context,
      String message, {
        Color backgroundColor = AppColor.blackColor,
        Color textColor = AppColor.whiteColor,
        Duration duration = const Duration(seconds: 2),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.medium.copyWith(
            color: textColor,
            fontSize: 14,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}