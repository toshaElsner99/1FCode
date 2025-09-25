
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

  // Stock Details Validators
  String? validateStockName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter stock name';
    }
    if (value.length < 2) {
      return 'Stock name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Stock name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'Stock name can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateStockSymbol(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 1) {
        return 'Stock symbol must be at least 1 character';
      }
      if (value.length > 10) {
        return 'Stock symbol must not exceed 10 characters';
      }
      if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
        return 'Stock symbol can only contain letters and numbers';
      }
    }
    return null;
  }

  String? validateNumberOfShares(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter number of shares';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter a valid number of shares';
    }
    final shares = int.tryParse(value);
    if (shares == null) {
      return 'Please enter a valid number';
    }
    if (shares <= 0) {
      return 'Number of shares must be greater than 0';
    }
    if (shares > 999999999) {
      return 'Number of shares cannot exceed 999,999,999';
    }
    return null;
  }

  String? validatePurchasePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter purchase price';
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return 'Please enter a valid price (e.g., 100 or 100.50)';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid number';
    }
    if (price <= 0) {
      return 'Purchase price must be greater than 0';
    }
    if (price > 999999.99) {
      return 'Purchase price cannot exceed ₹9,99,999.99';
    }
    return null;
  }

  String? validatePurchaseDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select purchase date';
    }
    return null;
  }

  // Mutual Fund Details Validators
  String? validateFundName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter fund name';
    }
    if (value.length < 2) {
      return 'Fund name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Fund name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'Fund name can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateAMC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter AMC name';
    }
    if (value.length < 2) {
      return 'AMC name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'AMC name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'AMC name can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateFolioNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter folio number';
    }
    if (value.length < 3) {
      return 'Folio number must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Folio number must not exceed 20 characters';
    }
    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
      return 'Folio number can only contain letters and numbers';
    }
    return null;
  }

  String? validateInvestmentAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter investment amount';
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return 'Please enter a valid amount (e.g., 1000 or 1000.50)';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Investment amount must be greater than 0';
    }
    if (amount > 999999999.99) {
      return 'Investment amount cannot exceed ₹99,99,99,999.99';
    }
    return null;
  }

  String? validateNAV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter NAV';
    }
    if (!RegExp(r'^\d+(\.\d{1,4})?$').hasMatch(value)) {
      return 'Please enter a valid NAV (e.g., 100.1234)';
    }
    final nav = double.tryParse(value);
    if (nav == null) {
      return 'Please enter a valid number';
    }
    if (nav <= 0) {
      return 'NAV must be greater than 0';
    }
    if (nav > 99999.9999) {
      return 'NAV cannot exceed 99,999.9999';
    }
    return null;
  }

  // Insurance Details Validators
  String? validatePolicyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter policy name';
    }
    if (value.length < 2) {
      return 'Policy name must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Policy name must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'Policy name can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validatePolicyNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter policy number';
    }
    if (value.length < 3) {
      return 'Policy number must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Policy number must not exceed 20 characters';
    }
    if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
      return 'Policy number can only contain letters and numbers';
    }
    return null;
  }

  String? validateInsuranceProvider(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter insurance provider';
    }
    if (value.length < 2) {
      return 'Insurance provider must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Insurance provider must not exceed 100 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s&.,-]+$').hasMatch(value)) {
      return 'Insurance provider can only contain letters, spaces, &, ., ,, -';
    }
    return null;
  }

  String? validateSumAssured(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter sum assured';
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return 'Please enter a valid amount (e.g., 100000 or 100000.50)';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Sum assured must be greater than 0';
    }
    if (amount > 999999999.99) {
      return 'Sum assured cannot exceed ₹99,99,99,999.99';
    }
    return null;
  }

  String? validatePremiumAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter premium amount';
    }
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
      return 'Please enter a valid amount (e.g., 1000 or 1000.50)';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Premium amount must be greater than 0';
    }
    if (amount > 999999.99) {
      return 'Premium amount cannot exceed ₹9,99,999.99';
    }
    return null;
  }

  String? validatePremiumFrequency(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select premium frequency';
    }
    return null;
  }

  String? validateStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select start date';
    }
    return null;
  }

  String? validateMaturityDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select maturity date';
    }
    return null;
  }
}