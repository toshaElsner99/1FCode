import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/app_utils.dart';
import 'package:oneFCode/utils/app_common_strings.dart';

class AddManuallyPopup extends StatelessWidget {
  const AddManuallyPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.transparentColor,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.05),
              blurRadius: 40,
              offset: const Offset(0, 16),
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppCommonString.addManually,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 18,
                    color: AppColor.blackColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(AppImage.crossIcon, width: 25,height: 25)
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              AppCommonString.chooseAssetType,
              style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                color: AppColor.greyText,
              ),
            ),
            const SizedBox(height: 24),
            
            // Asset Type Cards Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildAssetCard(
                  title: AppCommonString.bank,
                  description: AppCommonString.addBankAccounts,
                  gradientStart: AppColor.bankGradientStart,
                  gradientEnd: AppColor.bankGradientEnd,
                  borderColor: AppColor.bankBorderColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteConstant.addBankManually);
                  },
                ),
                _buildAssetCard(
                  title: AppCommonString.stock,
                  description: AppCommonString.addIndividualStocks,
                  gradientStart: AppColor.stockGradientStart,
                  gradientEnd: AppColor.stockGradientEnd,
                  borderColor: AppColor.stockBorderColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteConstant.addStockManually);
                  },
                ),
                _buildAssetCard(
                  title: AppCommonString.mutualFunds,
                  description: AppCommonString.addMutualFunds,
                  gradientStart: AppColor.mutualFundGradientStart,
                  gradientEnd: AppColor.mutualFundGradientEnd,
                  borderColor: AppColor.mutualFundBorderColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteConstant.addMutualFundsManually);
                  },
                ),
                _buildAssetCard(
                  title: AppCommonString.insurance,
                  description: AppCommonString.addInsurancePolicies,
                  gradientStart: AppColor.insuranceGradientStart,
                  gradientEnd: AppColor.insuranceGradientEnd,
                  borderColor: AppColor.insuranceBorderColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteConstant.addInsuranceManually);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetCard({
    required String title,
    required String description,
    required Color gradientStart,
    required Color gradientEnd,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientStart, gradientEnd],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(
                    AppImage.bankIcon,
                    width: 24,
                    height: 24,
                    color: AppColor.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Title
              Text(
                title,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16,
                  color: AppColor.blackColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              
              // Description
              Text(
                description,
                style: AppTextStyles.regular.copyWith(
                  fontSize: 12,
                  color: AppColor.greyText,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
