import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/circular_icon_widget.dart';
import 'package:oneFCode/utils/app_image.dart';

class ViewMutualFundDetailsScreen extends StatefulWidget {
  const ViewMutualFundDetailsScreen({super.key});

  @override
  State<ViewMutualFundDetailsScreen> createState() => _ViewMutualFundDetailsScreenState();
}

class _ViewMutualFundDetailsScreenState extends State<ViewMutualFundDetailsScreen> {
  // Transaction data
  final List<MFTransactionData> _transactions = [
    MFTransactionData(
      title: AppCommonString.sipInvestment,
      date: AppCommonString.sipDate1,
      amount: AppCommonString.sipAmount1,
      nav: AppCommonString.navValue1,
      isCredit: true,
    ),
    MFTransactionData(
      title: AppCommonString.lumpsumPurchase,
      date: AppCommonString.lumpsumDate,
      amount: AppCommonString.lumpsumAmount,
      nav: AppCommonString.navValue2,
      isCredit: false,
    ),
    MFTransactionData(
      title: AppCommonString.sipInvestment,
      date: AppCommonString.sipDate2,
      amount: AppCommonString.sipAmount2,
      nav: AppCommonString.navValue3,
      isCredit: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgColor,
      appBar: AppCommonAppBar(
        title: AppCommonString.mutualFundDetails,
        showBack: true,
        backgroundColor: AppColor.screenBgColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mutual Fund Summary Card
            _buildMFSummaryCard(),
            const SizedBox(height: 16),
            
            // NAV and XIRR Cards
            _buildNAVXIRRCards(),
            const SizedBox(height: 16),
            
            // Transaction History Section
            _buildTransactionHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMFSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.lightOrangeColor, // Light beige background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.orangeBorderColor, // Light blue border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fund Name and Type
          Text(
            AppCommonString.axisBluechipFund,
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppCommonString.largeCapEquityFund,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              color: AppColor.greyText,
            ),
          ),
          const SizedBox(height: 20),
          
          // Current Value Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  AppCommonString.currentValue,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColor.greyText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹1,24,546",
                  style: AppTextStyles.bold.copyWith(
                    fontSize: 24,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Investment and Returns Cards
          Row(
            children: [
              // Invested Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppCommonString.invested,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: AppColor.greyText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.investedAmount,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 18,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Returns Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppCommonString.returns,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: AppColor.greyText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.returnsPercentage,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 18,
                          color: AppColor.greenTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNAVXIRRCards() {
    return Row(
      children: [
        // NAV Card
        Expanded(
          child: _buildInfoCard(
            label: AppCommonString.nav,
            value: AppCommonString.navValue,
            imageName: AppImage.upArrowStockIcon,
            subtitle: AppCommonString.navDate,
            iconColor: AppColor.greenTextColor,
          ),
        ),
        const SizedBox(width: 12),
        
        // XIRR Card
        Expanded(
          child: _buildInfoCard(
            label: AppCommonString.xirr,
            value: AppCommonString.xirrValue,
            subtitle: AppCommonString.annualized,
            imageName: AppImage.percentageIcon,
            iconColor: AppColor.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required String subtitle,
    required String imageName,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: AppColor.blackColor,
                ),
              ),
              Image.asset(imageName, width: 20,height: 20),
            ],
          ),
          const SizedBox(height: 8),
          
          // Value
          Text(
            value,
            style: AppTextStyles.bold.copyWith(
              fontSize: 18,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 4),
          
          // Subtitle
          Text(
            subtitle,
            style: AppTextStyles.regular.copyWith(
              fontSize: 12,
              color: AppColor.greyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistorySection() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppCommonString.transactionsHistory,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: AppColor.blackColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to full transaction history
                },
                child: Text(
                  AppCommonString.viewAll,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColor.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Transaction List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _transactions.length,
            separatorBuilder: (context, index) => _buildDivider(),
            itemBuilder: (context, index) {
              final transaction = _transactions[index];
              return _buildMFTransactionItem(
                icon: transaction.isCredit
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                iconColor: transaction.isCredit
                    ? AppColor.greenTextColor
                    : AppColor.redColor,
                bgColor: transaction.isCredit ? AppColor.greenBGColor : AppColor.lightRedColor,
                title: transaction.title,
                date: transaction.date,
                amount: transaction.amount,
                nav: transaction.nav,
                amountColor: transaction.isCredit
                    ? AppColor.greenTextColor
                    : AppColor.redColor,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMFTransactionItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String date,
    required String amount,
    required String nav,
    required Color amountColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Transaction Icon
          CircularIconWidget(
            icon: icon,
            bgColor: bgColor,
            iconColor: iconColor,
          ),
          const SizedBox(width: 12),

          // Transaction Details
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
                  date,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: AppColor.greyText,
                  ),
                )
              ],
            ),
          ),

          // Amount
          Column(
            children: [
              Text(
                amount,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                nav,
                style: AppTextStyles.regular.copyWith(
                  fontSize: 12,
                  color: AppColor.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: AppColor.textFieldBorderColor.withOpacity(0.3),
    );
  }
}

class MFTransactionData {
  final String title;
  final String date;
  final String amount;
  final String nav;
  final bool isCredit;

  MFTransactionData({
    required this.title,
    required this.date,
    required this.amount,
    required this.nav,
    required this.isCredit,
  });
}
