import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/circular_icon_widget.dart';
import 'package:oneFCode/utils/app_image.dart';

class ViewInsuranceDetailsScreen extends StatefulWidget {
  const ViewInsuranceDetailsScreen({super.key});

  @override
  State<ViewInsuranceDetailsScreen> createState() => _ViewInsuranceDetailsScreenState();
}

class _ViewInsuranceDetailsScreenState extends State<ViewInsuranceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgColor,
      appBar: AppCommonAppBar(
        backgroundColor: AppColor.screenBgColor,
        title: AppCommonString.insuranceDetails,
        showBack: true,
        action: [
          IconButton(
            icon: Image.asset(AppImage.menuIcon, width: 24, height: 24),
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Insurance Summary Card
            _buildInsuranceSummaryCard(),
            const SizedBox(height: 16),
            
            // Policy Timeline Card
            _buildPolicyTimelineCard(),
            const SizedBox(height: 16),
            
            // Policy Documents Card
            _buildPolicyDocumentsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section - Plan Info
          Row(
            children: [
              // Insurance Icon
              Image.asset(AppImage.healthSecureIcon, width: 60,height: 60),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppCommonString.healthSecurePlan2025,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppCommonString.starHealthInsurance,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        color: AppColor.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Sum Insured Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.lightOrangeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppCommonString.sumInsured,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.greyText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppCommonString.sumInsuredAmount,
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 24,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Premium & Status Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Premium Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppCommonString.premium,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: AppColor.greyText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "₹12,500",
                        style: AppTextStyles.bold.copyWith(
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppCommonString.annually,
                        style: AppTextStyles.regular.copyWith(
                          fontSize: 14,
                          color: AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Vertical Divider
              Container(
                height: 50,
                width: 1,
                color: AppColor.greyText.withOpacity(0.2),
              ),
              
              // Status Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppCommonString.status,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                      color: AppColor.greyText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColor.greenTextColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.greenTextColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColor.greenTextColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Active",
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14,
                            color: AppColor.greenTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppCommonString.policyTimeline,
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Policy Start Date
          _buildTimelineItem(
            title: AppCommonString.policyStartDate,
            value: "Dec 25, 2023",
            isHighlighted: false,
          ),
          const SizedBox(height: 16),
          
          // Policy End Date
          _buildTimelineItem(
            title: AppCommonString.policyEndDate,
            value: "Jan 15, 2024",
            isHighlighted: false,
          ),
          const SizedBox(height: 16),
          
          // Next Renewal
          _buildTimelineItem(
            title: "Next Renewal",
            subtitle: AppCommonString.daysRemaining,
            value: "Jan 16, 2024",
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDocumentsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppCommonString.policyDocuments,
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Policy Certificate
          _buildDocumentItem(
            title: AppCommonString.policyCertificate,
            subtitle: AppCommonString.fileSize,
            date: AppCommonString.documentDate,
          ),
          const SizedBox(height: 16),
          
          // Terms & Conditions
          _buildDocumentItem(
            title: AppCommonString.termsAndConditions,
            subtitle: AppCommonString.fileSize,
            date: AppCommonString.documentDate,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    String? subtitle,
    required String value,
    required bool isHighlighted,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Green Circle Icon
          CircularIconWidget(
            icon: Icons.arrow_upward,
            bgColor: AppColor.greenBGColor,
            iconColor: AppColor.greenTextColor,
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 12,
                      color: AppColor.greyText,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Value
          Text(
            value,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: isHighlighted ? AppColor.primary : AppColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Green Circle Icon
          CircularIconWidget(
            icon: Icons.arrow_upward,
            bgColor: AppColor.greenBGColor,
            iconColor: AppColor.greenTextColor,
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: AppColor.greyText,
                  ),
                ),
              ],
            ),
          ),

          // Date
          Text(
            date,
            style: AppTextStyles.medium.copyWith(
              fontSize: 14,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}