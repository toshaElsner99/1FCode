import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_textfields.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _netWorthController = TextEditingController(text: "Your Net worth");
  final FocusNode _netWorthFocusNode = FocusNode();
  
  // Draggable tiles data
  List<Map<String, dynamic>> tiles = [
    {
      'id': 'bank',
      'title': AppCommonString.bank,
      'value': '₹0',
    },
    {
      'id': 'stock',
      'title': AppCommonString.stock,
      'value': '₹0',
    },
    {
      'id': 'insurance',
      'title': AppCommonString.insurance,
      'value': '₹0',
    },
    {
      'id': 'mutualFunds',
      'title': AppCommonString.mutualFunds,
      'value': '₹0',
    },
  ];

  // Other section data
  List<Map<String, dynamic>> otherItems = [
    {
      'title': AppCommonString.stockOptions,
      'value': '₹₹',
      'action': AppCommonString.manage,
    },
    {
      'title': AppCommonString.restrictedStockUnits,
      'value': '₹₹',
      'action': AppCommonString.track,
    },
    {
      'title': AppCommonString.employeeBenefits,
      'value': '₹₹',
      'action': AppCommonString.review,
    },
  ];

  @override
  void dispose() {
    _netWorthController.dispose();
    _netWorthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom AppBar with Profile Header
            _buildCustomAppBar(context),
            // Draggable Tiles Section
            _buildDraggableTilesSection(),
            // Trading Card Section
            _buildTradingCard(),
            // Other Section
            _buildOtherSection(),
            // Rest of the content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Additional content can be added here
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.lightOrangeColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and Age Tag Row
                        Row(
                          children: [
                            Text(
                              AppCommonString.jessicaLee,
                              style: AppTextStyles.semiBold.copyWith(
                                fontSize: 18,
                                color: AppColor.blackColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColor.whiteColor)
                              ),
                              child: Text(
                                "24 Age",
                                style: AppTextStyles.medium.copyWith(
                                  fontSize: 11,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Risk Profile Row
                        Row(
                          children: [
                            Text(
                              AppCommonString.riskProfile,
                              style: AppTextStyles.regular.copyWith(
                                fontSize: 14,
                                color: AppColor.blackColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Risk Profile Gauge Icon
                            Image.asset(
                              AppImage.riskProfileIcon,
                              width: 30,height: 30
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Profile Picture
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColor.whiteColor,
                    child: ClipOval(
                      child: Image.network(
                        "https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2018-09/shutterstock_648907024.jpg?itok=7lrLYx-B",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Net Worth TextField
              AppTextField(
                label: AppCommonString.yourNetWorth,
                isFilledColor: true,
                controller: _netWorthController,
                focusNode: _netWorthFocusNode,
                isNotEnabled: false,
                style: AppTextStyles.regular.copyWith(fontSize: 14, color: AppColor.blackColor),
                suffixText: AppCommonString.netWorthValue,
                showLabel: false,
                contentPaddingOverride: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColor.whiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColor.whiteColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColor.whiteColor),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableTilesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.7,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          return LongPressDraggable<Map<String, dynamic>>(
            data: tiles[index],
            feedback: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: _buildDraggableTile(tiles[index], index),
            ),
            childWhenDragging: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColor.primary.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: DragTarget<Map<String, dynamic>>(
              onWillAccept: (data) => data != null && data['id'] != tiles[index]['id'],
              onAccept: (draggedItem) {
                setState(() {
                  final draggedIndex = tiles.indexWhere((item) => item['id'] == draggedItem['id']);
                  final targetIndex = index;
                  
                  if (draggedIndex != targetIndex) {
                    final item = tiles.removeAt(draggedIndex);
                    tiles.insert(targetIndex, item);
                  }
                });
              },
              builder: (context, candidateData, rejectedData) {
                return _buildDraggableTile(tiles[index], index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDraggableTile(Map<String, dynamic> tile, int index) {
    return Container(
      key: ValueKey(tile['id']),
      child: Material(
        color: AppColor.transparentColor,
        child: InkWell(
          onTap: () {
            // Handle tile tap
            print('Tapped on ${tile['title']}');
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title (Top Left)
                Text(
                  tile['title'],
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                const Spacer(),
                // Bottom Row with Value and Add Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Value (Bottom Left)
                    Text(
                      tile['value'],
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 18,
                        color: AppColor.blackColor,
                      ),
                    ),
                    // Add Button (Bottom Right)
                    GestureDetector(
                      onTap: () {
                        print('Add button tapped for ${tile['title']}');
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColor.whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTradingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.primary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Trading text and currency symbols
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppCommonString.trading,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 16,
                  color: AppColor.greyText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "₹₹₹",
                style: AppTextStyles.bold.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ],
          ),
          // Right side - Upmove button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.lightOrangeColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.primary)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppCommonString.upmove,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Image.asset(
                  AppImage.upmoveRedirectIcon,
                  width: 16, height: 16,
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "Other" and "View All"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppCommonString.other,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('View All tapped');
                },
                child: Text(
                  AppCommonString.viewAll,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColor.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // List of cards
          ...otherItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildOtherCard(item),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildOtherCard(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Title and value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['value'],
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
              ],
            ),
          ),
          // Right side - Action button
          GestureDetector(
            onTap: () {
              print('${item['action']} tapped for ${item['title']}');
            },
            child: Text(
              item['action'],
              style: AppTextStyles.medium.copyWith(
                fontSize: 14,
                color: AppColor.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

}