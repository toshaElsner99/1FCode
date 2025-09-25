import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';

class ViewBankDetailsScreen extends StatefulWidget {
  const ViewBankDetailsScreen({super.key});

  @override
  State<ViewBankDetailsScreen> createState() => _ViewBankDetailsScreenState();
}

class _ViewBankDetailsScreenState extends State<ViewBankDetailsScreen> {
  bool _isBalanceVisible = true;

  // Transaction data
  final List<TransactionData> _transactions = [
    TransactionData(
      title: AppCommonString.salaryDeposit,
      date: AppCommonString.dec252023,
      amount: AppCommonString.salaryAmount,
      isCredit: true,
    ),
    TransactionData(
      title: AppCommonString.bonusPayment,
      date: AppCommonString.jan152024,
      amount: AppCommonString.bonusAmount,
      isCredit: false,
    ),
    TransactionData(
      title: AppCommonString.groceryStore,
      date: AppCommonString.feb282024,
      amount: AppCommonString.groceryAmount,
      isCredit: false,
    ),
    TransactionData(
      title: AppCommonString.electricBill,
      date: AppCommonString.feb102024,
      amount: AppCommonString.electricAmount,
      isCredit: true,
    ),
    TransactionData(
      title: AppCommonString.electronicStore,
      date: "Mar 5, 2024",
      amount: "-₹89.50",
      isCredit: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgColor,
      appBar: AppCommonAppBar(
        title: AppCommonString.bankDetails,
        showBack: true,
        action: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColor.blackColor),
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
            // Bank Account Information Card
            _buildBankInfoCard(),
            const SizedBox(height: 16),
            
            // Available Balance Card
            _buildBalanceCard(),
            const SizedBox(height: 24),
            
            // Recent Transactions Section
            _buildRecentTransactionsSection(),
            const SizedBox(height: 16),
            
            // Transaction List
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBankInfoCard() {
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
      child: Row(
        children: [
          // Bank Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppImage.bankHomeIcon,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to Material icon if image fails to load
                  return const Icon(
                    Icons.account_balance,
                    color: AppColor.whiteColor,
                    size: 30,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Bank Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppCommonString.hdfcBank,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 18,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppCommonString.savingAccount,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.greyText,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Account Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppCommonString.accountNumber,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        color: AppColor.greyText,
                      ),
                    ),
                    Text(
                      AppCommonString.maskedAccountNumber,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Account Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppCommonString.accountType,
                      style: AppTextStyles.regular.copyWith(
                        fontSize: 14,
                        color: AppColor.greyText,
                      ),
                    ),
                    Text(
                      AppCommonString.savings,
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 14,
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.lightOrangeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with eye icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppCommonString.availableBalance,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF333333),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.primary,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Balance Amount
          Text(
            _isBalanceVisible ? AppCommonString.balanceAmount : "••••••",
            style: AppTextStyles.bold.copyWith(
              fontSize: 28,
              color: AppColor.primary,
            ),
          ),
          const SizedBox(height: 8),
          
          // Last Updated
          Text(
            AppCommonString.lastUpdated,
            style: AppTextStyles.regular.copyWith(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppCommonString.recentTransactions,
          style: AppTextStyles.semiBold.copyWith(
            fontSize: 18,
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
              decorationColor: AppColor.primary,
              decoration: TextDecoration.underline
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return Container(
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _transactions.length,
        separatorBuilder: (context, index) => _buildDivider(),
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return _buildTransactionItem(
            icon: transaction.isCredit ? Icons.arrow_upward : Icons.arrow_downward,
            iconColor: transaction.isCredit ? AppColor.greenTextColor : AppColor.redColor,
            title: transaction.title,
            date: transaction.date,
            amount: transaction.amount,
            amountColor: transaction.isCredit ? AppColor.greenTextColor : AppColor.redColor,
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Transaction Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
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
                    fontSize: 14,
                    color: AppColor.greyText,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount
          Text(
            amount,
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 16,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColor.textFieldBorderColor.withOpacity(0.3),
    );
  }
}

class TransactionData {
  final String title;
  final String date;
  final String amount;
  final bool isCredit;

  TransactionData({
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  });
}
