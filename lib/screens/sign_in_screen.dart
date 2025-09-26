import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:pinput/pinput.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import '../services/storage_service/storage_service.dart';
import '../utils/app_utils.dart';
import '../widgets/app_button.dart';
import '../widgets/app_common_textfields.dart';
import '../widgets/app_common_appbar.dart';
import 'package:oneFCode/services/storage_service/storage_keys.dart';
import 'package:oneFCode/utils/validators.dart';
import 'package:oneFCode/widgets/common_popup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  bool _otpSent = false; // ✅ toggle UI
  final _otpController = TextEditingController();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _otpFocus = FocusNode();


  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    // Close keyboard when disposing
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close keyboard when tapping outside text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppCommonAppBar(
          title: AppCommonString.signIn,
          showBack: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildMobileForm(),
                if(_otpSent)...{
                  _buildOtpForm()
                }
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Mobile Number UI
  Widget _buildMobileForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppCommonString.enterMobileNumber,
            style: AppTextStyles.medium.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 6),
          Text(
            AppCommonString.willSendOTP,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: AppColor.greyText,
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: AppCommonString.mobileNumber,
            prefixText: "+91 ",
            isNotEnabled: !(_otpSent),
            controller: _mobileController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            focusNode: _mobileFocus,
            maxLength: 10,
            validator: (value) => AppValidators.instance.validateMobile(value),
          ),
          const SizedBox(height: 30),
          AppButton(
            text: AppCommonString.sendOtp,
            backgroundColor: _otpSent ? AppColor.orangeBorderColor : AppColor.primary,
            onPressed: !(_otpSent) ? () {
              if (_formKey.currentState!.validate()) {
                setState(() => _otpSent = true); // ✅ show OTP UI
                StorageService.instance.setString(StorageKeys.mobile, _mobileController.text.trim());
              }
            } : (){},
          ),
        ],
      ),
    );
  }

  /// OTP UI
  Widget _buildOtpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          AppCommonString.enterOtp,
          style: AppTextStyles.medium.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 16),

        /// OTP Fields
        otpInputField(controller: _otpController,onCompleted: (val){}),

        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              "${AppCommonString.sentTo} +91 ${_mobileController.text}",
              style: AppTextStyles.medium.copyWith(fontSize: 14, color: AppColor.greyText),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => setState(() => _otpSent = false),
              child: Text(
                AppCommonString.edit,
                style: AppTextStyles.semiBold.copyWith(color: AppColor.primary ,decoration: TextDecoration.underline, decorationColor: AppColor.primary),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            // TODO: Resend OTP API
          },
          child: Align(
            alignment: AlignmentGeometry.center,
            child: Text(
              AppCommonString.didNotGetACode,
              style: AppTextStyles.semiBold.copyWith(color: AppColor.primary, fontSize: 14),
            ),
          ),
        ),

        const SizedBox(height: 24),
        AppButton(
          text: AppCommonString.continueText,
          onPressed: () async {
            // TODO: Verify OTP via API; on success navigate to selfie
            await _generateFCMToken();
            PopupService.instance.showSuccessPopupWithAutoDismiss(
              context,
              AppCommonString.mobileVerifiedSuccess,
              onDismiss: () => RouteConstant.selfieScreen.pushNamed(),
            );
          },
        ),
      ],
    );
  }

  Widget otpInputField({
    required TextEditingController controller,
    void Function(String)? onCompleted,
  }) {
    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width / 4,
      height: 60,
      textStyle: AppTextStyles.medium.copyWith(fontSize: 16, color: AppColor.blackColor),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        border: Border.all(color: AppColor.textFieldBorderColor), // Border color
        borderRadius: BorderRadius.circular(12), // 👈 Rounded edges
      ),
    );

    return KeyboardActions(
      disableScroll: true,
      config: AppUtils.instance.keyboardConfigIos(_otpFocus),
      child: Pinput(
        length: 4,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        showCursor: true, // 👈 Cursor always visible
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            border: Border.all(color: AppColor.textFieldBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            border: Border.all(color: AppColor.textFieldBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onCompleted: onCompleted,
      ),
    );
  }

  /// Generate FCM Token after successful OTP verification
  Future<void> _generateFCMToken() async {
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('Firebase not initialized. Please configure Firebase first.');
        return;
      }

      // Request permission for notifications
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get FCM token
        String? token = await FirebaseMessaging.instance.getToken();
        
        if (token != null) {
          // Store FCM token in local storage
          await StorageService.instance.setString(StorageKeys.fcmToken, token);
          
          // TODO: Send FCM token to your backend server
          // await _sendFCMTokenToServer(token);
          
          print('FCM Token generated: $token');
        } else {
          print('Failed to get FCM token');
        }
      } else {
        print('Notification permission denied');
      }
    } catch (e) {
      print('Error generating FCM token: $e');
      // Continue with app flow even if FCM fails
    }
  }

  /// Send FCM token to backend server (implement as needed)
  Future<void> _sendFCMTokenToServer(String token) async {
    try {
      // TODO: Implement API call to send FCM token to your backend
      // Example:
      // final response = await ApiService.instance.sendFCMToken({
      //   'mobile': _mobileController.text.trim(),
      //   'fcm_token': token,
      // });
      
      print('FCM token sent to server: $token');
    } catch (e) {
      print('Error sending FCM token to server: $e');
    }
  }
}
