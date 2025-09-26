import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ViewStockDetailsScreen extends StatefulWidget {
  const ViewStockDetailsScreen({super.key});

  @override
  State<ViewStockDetailsScreen> createState() => _ViewStockDetailsScreenState();
}

class _ViewStockDetailsScreenState extends State<ViewStockDetailsScreen> {
  // Price range values
  final double _minPrice = 2220.30;
  final double _maxPrice = 3024.90;
  final double _currentPrice = 2847.50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgColor,
      appBar: AppCommonAppBar(
        title: AppCommonString.stockDetails,
        backgroundColor: AppColor.screenBgColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stock Information Card
            _buildStockInfoCard(),
            const SizedBox(height: 16),
            
            // Your Holdings Section
            _buildHoldingsSection(),
            const SizedBox(height: 16),
            
            // 52 Week Range Section
            _buildWeekRangeSection(),
            const SizedBox(height: 16),
            
            // Transaction History Section
            _buildTransactionHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStockInfoCard() {
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
            children: [
              // Company Logo
              Image.asset(AppImage.bankHomeIcon, width: 60,height: 60),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppCommonString.relianceIndustriesLtd,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 16,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppCommonString.relianceNS,
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
          
          // Price Information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppCommonString.currentPrice,
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 20,
                      color: AppColor.blackColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        AppCommonString.priceChange,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14,
                          color: AppColor.greenTextColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_upward,
                        color: AppColor.greenTextColor,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppCommonString.lastUpdated,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: AppColor.greyText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppCommonString.lastUpdatedTime,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: AppColor.blackColor,
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

  Widget _buildHoldingsSection() {
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
            AppCommonString.yourHoldings,
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Holdings Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.0,
            children: [
              _buildHoldingItem(AppCommonString.sharesOwned, AppCommonString.sharesOwnedValue),
              _buildHoldingItem(AppCommonString.totalInvestment, AppCommonString.totalInvestmentValue),
              _buildHoldingItem(AppCommonString.currentValue, AppCommonString.currentValueAmount),
              _buildHoldingItem(AppCommonString.pnl, AppCommonString.pnlValue, isProfit: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoldingItem(String label, String value, {bool isProfit = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.screenBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              color: AppColor.greyText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 18,
              color: isProfit ? AppColor.greenTextColor : AppColor.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekRangeSection() {
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
            AppCommonString.weekRange,
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // 52W High and Low
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppCommonString.weekHigh,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: AppColor.greyText,
                ),
              ),
              Text(
                AppCommonString.weekHighValue,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 14,
                  color: AppColor.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: AppColor.textFieldBorderColor,height: 2,),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppCommonString.weekLow,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: AppColor.greyText,
                ),
              ),
              Text(
                AppCommonString.weekLowValue,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 14,
                  color: AppColor.blackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Price Range Slider
          _buildPriceRangeSlider(),
          const SizedBox(height: 8),
          Center(
            child: Text(
              AppCommonString.currentPriceLabel,
              style: AppTextStyles.medium.copyWith(
                fontSize: 12,
                color: AppColor.greyText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return SfSlider(
      min: _minPrice,
      max: _maxPrice,
      value: _currentPrice,
      showTicks: false,
      showLabels: false,
      enableTooltip: false,
      activeColor: AppColor.greenTextColor,
      inactiveColor: AppColor.greenTextColor.withOpacity(0.2),
      onChanged: (dynamic value) {
        // Handle slider changes if needed
      },
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
                AppCommonString.transactionHistory,
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
          
          // Sample transaction items
          _buildTransactionItem(AppCommonString.buyTransaction, AppCommonString.buyDescription, AppCommonString.buyDate, AppCommonString.buyAmount, true),
          const SizedBox(height: 12),
          _buildTransactionItem(AppCommonString.dividendTransaction, AppCommonString.dividendDescription, AppCommonString.dividendDate, AppCommonString.dividendAmount, true),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String type, String description, String date, String amount, bool isCredit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Transaction Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCredit ? AppColor.greenTextColor.withOpacity(0.1) : AppColor.redColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: isCredit ? AppColor.greenTextColor : AppColor.redColor,
                width: 2,
              ),
            ),
            child: Icon(
              isCredit ? Icons.arrow_upward : Icons.arrow_downward,
              color: isCredit ? AppColor.greenTextColor : AppColor.redColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: AppColor.greyText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: AppColor.greyText,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            amount,
            style: AppTextStyles.medium.copyWith(
              fontSize: 16,
              color: isCredit ? AppColor.greenTextColor : AppColor.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
