import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/common_popup.dart';
import 'package:oneFCode/services/storage_service/storage_service.dart';
import 'package:oneFCode/utils/app_utils.dart';
import 'package:oneFCode/services/storage_service/storage_keys.dart';
import 'subscription_screen.dart';
import 'nominees_screen.dart';
import 'notifications_screen.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  String? _photoPath;
  String _userName = "Mark Wood"; // Default name, can be loaded from storage

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final firstName = await StorageService.instance.getString(StorageKeys.firstName) ?? '';
    final lastName = await StorageService.instance.getString(StorageKeys.lastName) ?? '';
    final selfie = await StorageService.instance.getString(StorageKeys.selfiePath);
    
    setState(() {
      _userName = firstName.isNotEmpty && lastName.isNotEmpty 
          ? "$firstName $lastName" 
          : "Mark Wood";
      _photoPath = selfie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: AppCommonString.profile,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
        showBack: false
      ),
      backgroundColor: AppColor.screenBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // User Profile Section
                  _buildUserProfileSection(),
                  const SizedBox(height: 30),
        
                  // Menu Options Card
                  _buildMenuOptionsCard(),
                  // const SizedBox(height: 10)
                ],
              ),
            ),
            // Log Out Button
            _buildLogOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfileSection() {
    return Row(
      children: [
        // Profile Picture
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColor.textFieldBorderColor,
          backgroundImage: (_photoPath != null && File(_photoPath!).existsSync()) 
              ? FileImage(File(_photoPath!)) 
              : null,
          child: (_photoPath == null || !File(_photoPath!).existsSync()) 
              ? const Icon(Icons.person, size: 24, color: AppColor.whiteColor)
              : null,
        ),
        const SizedBox(width: 16),
        
        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppCommonString.hey,
                style: AppTextStyles.medium.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 16,
                ),
              ),
              Text(
                _userName,
                style: AppTextStyles.medium.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        
        // Edit Profile Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.textFieldBorderColor),
          ),
          child: Text(
            AppCommonString.editProfile,
            style: AppTextStyles.medium.copyWith(
              color: AppColor.primary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOptionsCard() {
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
      child: Column(
        children: [
          _buildMenuItem(
            icon: AppImage.subscriptionStatusIcon,
            title: AppCommonString.subscriptionStatus,
            onTap: () => _onMenuItemTap(AppCommonString.subscriptionStatus),
          ),
          _buildMenuItem(
            icon: AppImage.notificationBellIcon,
            title: AppCommonString.notificationSettings,
            onTap: () => _onMenuItemTap(AppCommonString.notificationSettings),
          ),
          _buildMenuItem(
            icon: AppImage.sosIcon,
            title: AppCommonString.sos,
            onTap: () => _onMenuItemTap(AppCommonString.sos),
          ),
          _buildMenuItem(
            icon: AppImage.willIcon,
            title: "${AppCommonString.will} ${AppCommonString.comingSoon}",
            onTap: null, // Disabled for coming soon
            isDisabled: true,
          ),
          _buildMenuItem(
            icon: AppImage.deathCertiIcon,
            title: AppCommonString.deathCertificate,
            onTap: () => _onMenuItemTap(AppCommonString.deathCertificate),
          ),
          _buildMenuItem(
            icon: AppImage.nomineeIcon,
            title: AppCommonString.nomineesInfo,
            onTap: () => _onMenuItemTap(AppCommonString.nomineesInfo),
          ),
          _buildMenuItem(
            icon: Icons.delete_outline,
            title: AppCommonString.deleteAccount,
            onTap: _onDeleteAccount,
            isRedColor: true,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required dynamic icon, // Changed to dynamic to accept both String and IconData
    required String title,
    required VoidCallback? onTap,
    bool isDisabled = false,
    bool showDivider = true,
    bool isRedColor = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Icon handling for both String (asset) and IconData
            if (icon is String)
              Image.asset(
                icon,
                color: isDisabled ? AppColor.greyText : (isRedColor ? AppColor.redColor : AppColor.blackColor),
                width: 24,
                height: 24
              )
            else if (icon is IconData)
              Icon(
                icon,
                color: isDisabled ? AppColor.greyText : (isRedColor ? AppColor.redColor : AppColor.blackColor),
                size: 24,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium.copyWith(
                  color: isDisabled ? AppColor.greyText : (isRedColor ? AppColor.redColor : AppColor.blackColor),
                  fontSize: 14,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDisabled ? AppColor.greyText : (isRedColor ? AppColor.redColor : AppColor.blackColor),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLogOutButton() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
        ),
        child: TextButton(
          onPressed: _onLogOut,
          child: Text(
            AppCommonString.logOut,
            style: AppTextStyles.semiBold.copyWith(
              color: AppColor.redColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _onMenuItemTap(String menuItem) {
    // Handle menu item taps
    if (menuItem == AppCommonString.subscriptionStatus) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SubscriptionStatusScreen(),
        ),
      );
    } else if (menuItem == AppCommonString.nomineesInfo) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NomineesScreen(),
        ),
      );
    } else if (menuItem == AppCommonString.notificationSettings) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NotificationsScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$menuItem tapped'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _onDeleteAccount() {
    ConfirmationDialog.show(
      context: context,
      title: AppCommonString.deleteAccount,
      message: '${AppCommonString.deleteAccountConfirmation}\n\n${AppCommonString.deleteAccountWarning}',
      confirmText: AppCommonString.deleteAccount,
      cancelText: AppCommonString.cancel,
      onConfirm: () {
        _confirmDeleteAccount();
      },
    );
  }

  void _confirmDeleteAccount() {
    ConfirmationDialog.show(
      context: context,
      title: AppCommonString.finalConfirmation,
      message: AppCommonString.typeDeleteToConfirm,
      confirmText: AppCommonString.delete,
      cancelText: AppCommonString.cancel,
      onConfirm: () {
        // Handle account deletion logic here
        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.accountDeletedSuccess,
          backgroundColor: AppColor.greenTextColor,
          duration: const Duration(seconds: 2),
        );
        // Navigate to login screen or splash screen
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/', // Replace with your login route
          (route) => false,
        );
      },
    );
  }

  void _onLogOut() {
    ConfirmationDialog.show(
      context: context,
      title: AppCommonString.logOut,
      message: AppCommonString.logoutConfirmation,
      confirmText: AppCommonString.logOut,
      cancelText: AppCommonString.cancel,
      onConfirm: () {
        // Handle logout logic here
        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.loggedOutSuccess,
          backgroundColor: AppColor.greenTextColor,
          duration: const Duration(seconds: 1),
        );
      },
    );
  }
}
