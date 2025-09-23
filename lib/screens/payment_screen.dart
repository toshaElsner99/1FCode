import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/utils/app_utils.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.razorpay;
  final String _amount = "₹365";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: AppCommonString.payment,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
      ),
      backgroundColor: AppColor.screenBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary Section
            _buildPaymentSummary(),
            const SizedBox(height: 30),
            
            // Payment Method Tabs
            _buildPaymentMethodTabs(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.lightOrangeColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primary)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppCommonString.paymentSummary,
            style: AppTextStyles.medium.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          
          Text(
            _amount,
            style: AppTextStyles.bold.copyWith(
              fontSize: 30,
              color: AppColor.primary,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            AppCommonString.annualSubscriptionGst,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: AppColor.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.tabBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildPaymentTab(
                        title: AppCommonString.razorpay,
                        isSelected: _selectedPaymentMethod == PaymentMethod.razorpay,
                        onTap: () => _selectPaymentMethod(PaymentMethod.razorpay),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildPaymentTab(
                        title: AppCommonString.manualPayment,
                        isSelected: _selectedPaymentMethod == PaymentMethod.manual,
                        onTap: () => _selectPaymentMethod(PaymentMethod.manual),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Payment Method Details
            _buildPaymentMethodDetails(),

            // Pay Now Button (only for Razorpay)
            if (_selectedPaymentMethod == PaymentMethod.razorpay) ...[
              const SizedBox(height: 30),
              _buildPayNowButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: isSelected ? AppColor.whiteColor : AppColor.blackColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodDetails() {
    if (_selectedPaymentMethod == PaymentMethod.razorpay) {
      return _buildRazorpayDetails();
    } else {
      return _buildComingSoon();
    }
  }

  Widget _buildRazorpayDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.textFieldBorderColor),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Security Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  AppImage.securePaymentIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Payment Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppCommonString.securePayment,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppCommonString.poweredByRazorpay,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 12,
                        color: AppColor.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Text(
            AppCommonString.paySecurelyUsing,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: AppColor.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Text(
          AppCommonString.comingSoonPayment,
          style: AppTextStyles.semiBold.copyWith(
            fontSize: 24,
            color: AppColor.greyText,
          ),
        ),
      ),
    );
  }

  Widget _buildPayNowButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.primary, width: 2),
        ),
        child: Material(
          color: AppColor.whiteColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _onPayNow,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  AppCommonString.payNow,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 16,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectPaymentMethod(PaymentMethod method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  void _onPayNow() {
    if (_selectedPaymentMethod == PaymentMethod.razorpay) {
      // Navigate to success screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PaymentSuccessScreen(),
        ),
      );
    } else {
      // Handle manual payment
      AppUtils.instance.showSnackBar(
        context,
        "Please contact support for manual payment",
        backgroundColor: AppColor.primary,
      );
    }
  }
}

enum PaymentMethod {
  razorpay,
  manual,
}
