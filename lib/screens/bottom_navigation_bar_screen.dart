import 'package:flutter/material.dart';
import 'package:oneFCode/screens/profile_settings_screen.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/screens/notifications_screen.dart';
import 'package:oneFCode/screens/home_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final int? index;

  const BottomNavigationBarScreen({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return <Widget>[
      const HomeScreen(),
      const ProfileSettingsScreen(),
      const NotificationsScreen(),
      const ProfileSettingsScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }

  onChangeTab(index) {
    setState(() {
      _selectedIndex = index;
    });
    print("selected tab is $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildScreens().elementAt(_selectedIndex),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColor.primary,
            elevation: 0, // Remove default elevation since we're using custom shadow
            onPressed: () {
              print("Add button tapped");
              // Navigate to add screen or show bottom sheet
              _showAddBottomSheet(context);
            },
            child: const Icon(
              Icons.add,
              color: AppColor.whiteColor,
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColor.whiteColor,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Home tab
                InkWell(
                  onTap: () {
                    onChangeTab(0);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 28,
                        color: _selectedIndex == 0
                            ? AppColor.primary
                            : AppColor.greyText,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.home,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? AppColor.primary
                              : AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
                // Market tab
                InkWell(
                  onTap: () {
                    onChangeTab(1);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bar_chart_outlined,
                        size: 28,
                        color: _selectedIndex == 1
                            ? AppColor.primary
                            : AppColor.greyText,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.market,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? AppColor.primary
                              : AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
                // Notifications tab
                InkWell(
                  onTap: () {
                    onChangeTab(2);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 28,
                        color: _selectedIndex == 2
                            ? AppColor.primary
                            : AppColor.greyText,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.notificationsTab,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? AppColor.primary
                              : AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
                // Settings tab
                InkWell(
                  onTap: () {
                    onChangeTab(3);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings_outlined,
                        size: 28,
                        color: _selectedIndex == 3
                            ? AppColor.primary
                            : AppColor.greyText,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppCommonString.settings,
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 12,
                          color: _selectedIndex == 3
                              ? AppColor.primary
                              : AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColor.greyText.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppCommonString.addNewItem,
                  style: AppTextStyles.semiBold.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAddOption(
                      icon: Icons.add_photo_alternate_outlined,
                      title: AppCommonString.addPhoto,
                      onTap: () {
                        Navigator.pop(context);
                        // Handle add photo
                      },
                    ),
                    _buildAddOption(
                      icon: Icons.add_location_outlined,
                      title: AppCommonString.addLocation,
                      onTap: () {
                        Navigator.pop(context);
                        // Handle add location
                      },
                    ),
                    _buildAddOption(
                      icon: Icons.add_task_outlined,
                      title: AppCommonString.addTask,
                      onTap: () {
                        Navigator.pop(context);
                        // Handle add task
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.lightOrangeColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.orangeBorderColor),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: AppColor.primary,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.medium.copyWith(
                fontSize: 12,
                color: AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
