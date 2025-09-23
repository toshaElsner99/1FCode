import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/widgets/common_popup.dart';
import 'package:oneFCode/utils/app_utils.dart';

class SubscriptionStatusScreen extends StatefulWidget {
  const SubscriptionStatusScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionStatusScreen> createState() => _SubscriptionStatusScreenState();
}

class _SubscriptionStatusScreenState extends State<SubscriptionStatusScreen> {
  // Sample subscription data - in real app, this would come from API/storage
  final String _planName = AppCommonString.annualPlan;
  final String _price = "₹365";
  final String _period = AppCommonString.perYear;
  final String _status = AppCommonString.active;
  final String _startDate = "Jan 15, 2023";
  final String _endDate = "Jan 15, 2024";
  final String _nextRenewal = "Jan 15, 2024";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: AppCommonString.subscription,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
        showBack: true,
        action: [
          Align(
              alignment: AlignmentGeometry.centerRight,
              child: Image.asset(AppImage.menuIcon, width: 30,height: 30))
        ],
      ),
      backgroundColor: AppColor.screenBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Subscription Details Card
            _buildSubscriptionCard(),
            const SizedBox(height: 50),
            
            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard() {
    return Container(
      width: double.infinity,
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plan Name and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _planName,
                      style: AppTextStyles.medium.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          _price,
                          style: AppTextStyles.semiBold.copyWith(
                            color: AppColor.primary,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          _period,
                          style: AppTextStyles.medium.copyWith(
                            color: AppColor.greyText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Active Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColor.greenBGColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColor.greenTextColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _status,
                      style: AppTextStyles.semiBold.copyWith(
                        color: AppColor.greenTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Date Information
          _buildDateRow(AppCommonString.startDate, _startDate),
          _buildDivider(),
          _buildDateRow(AppCommonString.endDate, _endDate),
          _buildDivider(),
          _buildDateRow(AppCommonString.nextRenewal, _nextRenewal, isHighlighted: true),
        ],
      ),
    );
  }

  Widget _buildDateRow(String label, String value, {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.medium.copyWith(
              color: AppColor.blackColor,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.regular.copyWith(
              color: isHighlighted ? AppColor.primary : AppColor.greyText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColor.textFieldBorderColor.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 4),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Manage Subscription Button
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: AppCommonString.manageSubscription,
            onPressed: _onManageSubscription,
          ),
        ),
        const SizedBox(height: 12),
        
        // Cancel Subscription Button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.primary),
            ),
            child: Material(
              color: AppColor.whiteColor.withOpacity(0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _onCancelSubscription,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      AppCommonString.cancelSubscription,
                      style: AppTextStyles.medium.copyWith(
                        color: AppColor.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onManageSubscription() {
    // Handle manage subscription action
    AppUtils.instance.showSnackBar(
      context,
      AppCommonString.manageSubscription,
      backgroundColor: AppColor.primary,
      duration: const Duration(seconds: 1),
    );
  }

  void _onCancelSubscription() {
    ConfirmationDialog.show(
      context: context,
      title: AppCommonString.cancelSubscription,
      message: AppCommonString.cancelSubscriptionMessage,
      confirmText: AppCommonString.cancelSubscription,
      cancelText: AppCommonString.keepSubscription,
      onConfirm: () {
        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.subscriptionCancelledSuccess,
          backgroundColor: AppColor.greenTextColor,
          duration: const Duration(seconds: 1),
        );
      },
    );
  }
}
