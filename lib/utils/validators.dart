// no Flutter imports needed for pure validators

import 'package:oneFCode/utils/app_common_strings.dart';

class AppValidators {
  AppValidators._internal();
  static final AppValidators instance = AppValidators._internal();

  /// PAN Validation: 5 letters + 4 digits + 1 letter
  String? validatePan(
      String? value, {
        String emptyMessage = AppCommonString.enterPanValidation,
        String invalidMessage = AppCommonString.validPanValidation,
      }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }

    final pan = value.trim().toUpperCase();
    final regExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');

    if (!regExp.hasMatch(pan)) {
      return invalidMessage;
    }

    return null; // ✅ Valid PAN
  }

  /// Validate First Name / Last Name for PAN
  String? validatePanName(
      String? value, {
        String emptyMessage = AppCommonString.enterNameValidation,
        String invalidMessage = AppCommonString.validNameValidation,
      }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }

    final name = value.trim();

    // Allow alphabets + spaces only
    final regExp = RegExp(r'^[A-Za-z ]+$');

    if (name.length < 2 || !regExp.hasMatch(name)) {
      return invalidMessage;
    }

    return null; // ✅ Valid Name
  }



  // Mobile: 10 digits (India)
  String? validateMobile(String? value, {
    String emptyMessage = AppCommonString.enterMobileValidation,
    String invalidMessage = AppCommonString.validMobileValidation,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) return invalidMessage;
    return null;
  }

  // OTP: 4 digits by default
  String? validateOtp(String? value, {
    int length = 4,
    String emptyMessage = AppCommonString.enterOtpValidation,
    String invalidMessage = AppCommonString.validOtpValidation,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    final regExp = RegExp('^\\d{$length}\$');
    if (!regExp.hasMatch(value.trim())) return invalidMessage;
    return null;
  }

  // DOB using segmented inputs
  String? validateDobParts(String day, String month, String year, {
    String emptyMessage = AppCommonString.enterDobValidation,
    String invalidMessage = AppCommonString.validDobValidation,
    String futureMessage = AppCommonString.futureDobValidation,
  }) {
    if (day.isEmpty || month.isEmpty || year.isEmpty) return emptyMessage;
    final int? d = int.tryParse(day);
    final int? m = int.tryParse(month);
    final int? y = int.tryParse(year);
    if (d == null || m == null || y == null) return invalidMessage;
    if (m < 1 || m > 12) return invalidMessage;
    if (y < 1900) return invalidMessage;
    try {
      final dt = DateTime(y, m, d);
      if (dt.year != y || dt.month != m || dt.day != d) return invalidMessage;
      final now = DateTime.now();
      if (dt.isAfter(DateTime(now.year, now.month, now.day))) return futureMessage;
    } catch (_) {
      return invalidMessage;
    }
    return null;
  }

  // Email validation
  String? validateEmail(String? value, {
    String emptyMessage = AppCommonString.enterEmailValidation,
    String invalidMessage = AppCommonString.validEmailValidation,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    final regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regExp.hasMatch(value.trim())) return invalidMessage;
    return null;
  }

  // Age validation
  String? validateAge(String? value, {
    String emptyMessage = AppCommonString.enterAgeValidation,
    String invalidMessage = AppCommonString.validAgeValidation,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    final age = int.tryParse(value.trim());
    if (age == null || age < 1 || age > 120) return invalidMessage;
    return null;
  }

  // Percentage validation
  String? validatePercentage(String? value, {
    String emptyMessage = AppCommonString.enterPercentageValidation,
    String invalidMessage = AppCommonString.validPercentageValidation,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    final percentage = int.tryParse(value.trim());
    if (percentage == null || percentage < 1 || percentage > 100) return invalidMessage;
    return null;
  }

  // Required field validation
  String? validateRequired(String? value, {
    required String emptyMessage,
  }) {
    if (value == null || value.trim().isEmpty) return emptyMessage;
    return null;
  }
}


