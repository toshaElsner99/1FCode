import 'package:flutter/material.dart';
import 'package:oneFCode/screens/market_screen.dart';
import 'package:oneFCode/screens/profile_settings_screen.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/screens/notifications_screen.dart';
import 'package:oneFCode/screens/home_screen.dart';
import 'package:oneFCode/screens/add_bank_details_screen.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final int? index;

  const BottomNavigationBarScreen({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState
    extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MarketScreen(),
    NotificationsScreen(),
    ProfileSettingsScreen(),
  ];

  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.bar_chart_outlined,
    Icons.notifications_outlined,
    Icons.settings_outlined,
  ];

  final List<String> _labels = [
    "Home",
    "Market",
    "Notifications",
    "Settings",
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // important for FAB notch
      body: Center(
        child: _screens[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColor.primary,
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.addBankDetailsScreen);
        },
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 🔹 Updated bottom nav with labels
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColor.primary : AppColor.tabTextColor;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Text(
                _labels[index],
                style: AppTextStyles.medium.copyWith(
                  fontSize: 12,
                  color: color,
                ),
              ),
            ],
          );
        },
        backgroundColor: AppColor.screenBgColor,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        splashColor: AppColor.primary.withOpacity(0.1),
        splashRadius: 20,
        height: 65,
        elevation: 8,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
