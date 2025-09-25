
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

  // Bank Details Validators
  String? validateAccountHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account holder name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter bank name';
    }
    if (value.length < 2) {
      return 'Bank name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Bank name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'Bank name can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateBranchName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter branch name';
    }
    if (value.length < 2) {
      return 'Branch name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Branch name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9\s&.,-]+$').hasMatch(value)) {
      return 'Branch name can only contain letters, numbers, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateIFSCCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter IFSC code';
    }
    if (value.length != 11) {
      return 'IFSC code must be exactly 11 characters';
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value.toUpperCase())) {
      return 'Invalid IFSC code format (e.g., SBIN0001234)';
    }
    return null;
  }

  String? validateBalance(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter balance';
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return 'Please enter a valid amount (e.g., 1000 or 1000.50)';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount < 0) {
      return 'Balance cannot be negative';
    }
    if (amount > 999999999.99) {
      return 'Balance cannot exceed ₹99,99,99,999.99';
    }
    return null;
  }

  String? validateNotes(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length > 500) {
        return 'Notes must not exceed 500 characters';
      }
    }
    return null;
  }
}